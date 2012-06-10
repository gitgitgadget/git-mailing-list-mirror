From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH_v1] add 'git credential' plumbing command
Date: Sun, 10 Jun 2012 16:02:24 -0500
Message-ID: <20120610210224.GA3112@burratino>
References: <1339267502-13803-1-git-send-email-Javier.Roucher-Iglesias@ensimag.imag.fr>
 <7vzk8baca0.fsf@alter.siamese.dyndns.org>
 <vpq1ulnnw81.fsf@bauges.imag.fr>
 <20120610203259.GA2380@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Javier.Roucher-Iglesias@ensimag.imag.fr, git@vger.kernel.org,
	Javier Roucher <jroucher@gmail.com>,
	Pavel Volek <Pavel.Volek@ensimag.imag.fr>,
	NGUYEN Kim Thuat <Kim-Thuat.Nguyen@ensimag.imag.fr>,
	ROUCHER IGLESIAS Javier <roucherj@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Jun 10 23:02:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SdpHT-0000ir-FB
	for gcvg-git-2@plane.gmane.org; Sun, 10 Jun 2012 23:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762Ab2FJVCe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Jun 2012 17:02:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36169 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2FJVCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2012 17:02:34 -0400
Received: by yenm10 with SMTP id m10so2123578yen.19
        for <git@vger.kernel.org>; Sun, 10 Jun 2012 14:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wyq9axgIVOANPQLhVYPvqm7Sv2ZjfpDC/LI3WeC0XZU=;
        b=s630SzEEaIbndxNz//clhJaxaErOU4TXPRnQ6V4DkFTOUANJc5Yo0yTE9CjmjGu6AP
         F+PlUA31oiOgnO2FwxmHm+K9MlQGPItgxGO/l4xOB0ER99rMf2n4kVdAKttoeaHGy1RU
         eA178z/u0dWD9xo2E/i4El+ziDMVxxaGQcWVaL9DkhjJFc8ixKJjODkwASkE9k2fsHLc
         AZe0xgd/Q1t6LD1g/rmAR6b9CcnVZD6xKkakUMS4bhekkNQdJ2I5fyecItGOi0hyVQwR
         FTU7SqbJ3QrSc/HQpLbLoqZmacXG0p8JfEr6PxoYSoMetuzmyXXaqp4022R/muZbhMOw
         l+Pg==
Received: by 10.236.115.133 with SMTP id e5mr17439322yhh.75.1339362151565;
        Sun, 10 Jun 2012 14:02:31 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id a34sm48185574yhh.0.2012.06.10.14.02.30
        (version=SSLv3 cipher=OTHER);
        Sun, 10 Jun 2012 14:02:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120610203259.GA2380@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199626>

Jonathan Nieder wrote:
> Matthieu Moy wrote:
>> Junio C Hamano <gitster@pobox.com> writes:

>>> Does "git credential" need to have a git repository (i.e. run in a
>>> git repository or in a working tree that is controlled by one)?
>>
>> It shouldn't (hence, should use RUN_SETUP_GENTLY).
>
> Rather, that means it should use 0:
>
> 			{ "credential", cmd_credential },

... and it turns out I'm talking nonsense.  RUN_SETUP_GENTLY would
be a sensible choice indeed, to allow the command to discover the
current repository and read .git/config from there indeed.

Sorry for the confusion,
Jonathan
