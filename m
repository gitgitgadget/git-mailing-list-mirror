From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 15:32:59 -0500
Message-ID: <20120610203259.GA2380@burratino>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <7vzk8baca0.fsf@alter.siamese.dyndns.org>
 <vpq1ulnnw81.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 22:33:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sdop1-00043N-3K
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 22:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab2FJUdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 16:33:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47483 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995Ab2FJUdI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 16:33:08 -0400
Received: by yenm10 with SMTP id m10so2118202yen.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 13:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s93+lcH3D1316z9ucWUG2hbIHKZUAqiVPELLDT3a5Uo=;
        b=Z25BevF/t4KEVaxn7+rnWXsbVVB8H0FX/yzhUIJ3KaOcHs1OpjY7D9vl+/YDej3yfG
         qVn5fFJptmVIhUVdpQZocjt7NZrfCs+nhSGb6N7B+CpTvBoIqFex9xhxmuCHpvr5LJUY
         Ah3YwFclIooGup9f5YgWn9vTCdV/t5xD8PQs1pqwdhsuBQ5/3E+yMvdw1mldB16TkTML
         sWQaC1xE+odTtGoW6EwYy5x7Lu4XHpGZBSe6B4v1tN5b8bKNmsp4CD04De0Lg8LGZ3gQ
         iTCmPBYMV1c9w8R6J2lRwZ0tQtsuktZWhlq+lR6Nj5CxCOGrDWU3IgaNb+yPYOYTpsHK
         57Gg==
Received: by 10.236.146.97 with SMTP id q61mr17423359yhj.113.1339360387493;
        Sun, 10 Jun 2012 13:33:07 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id d10sm21722261anm.17.2012.06.10.13.33.05
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 13:33:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <vpq1ulnnw81.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199624>

Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Does "git credential" need to have a git repository (i.e. run in a
>> git repository or in a working tree that is controlled by one)?
>
> It shouldn't (hence, should use RUN_SETUP_GENTLY).

Rather, that means it should use 0:

			{ "credential", cmd_credential },

[...]
> Actually, "git credential" has very little to do with Git, and could
> even be used in a git-unrelated script.

I suspect it would be simplest to make it a non-builtin.  There are
some examples to take inspiration from in the PROGRAM_OBJS variable of
the Makefile.

Hope that helps,
Jonathan
