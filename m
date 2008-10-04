From: "Elijah Newren" <newren@gmail.com>
Subject: Re: Question: How to list files that haven't been modified?
Date: Sat, 4 Oct 2008 17:01:49 -0600
Message-ID: <51419b2c0810041601g5f9e3007p70af60b5db7a066a@mail.gmail.com>
References: <loom.20081004T195935-879@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Burton" <markb@ordern.com>
X-From: git-owner@vger.kernel.org Sun Oct 05 01:03:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmG9M-0008DL-MI
	for gcvg-git-2@gmane.org; Sun, 05 Oct 2008 01:03:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754707AbYJDXBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Oct 2008 19:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754625AbYJDXBu
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Oct 2008 19:01:50 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:33652 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754622AbYJDXBu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Oct 2008 19:01:50 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2277341rvb.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2008 16:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=65+We8Nsj0itKkggPRKzvRZW1OQ9WGP5g1na+qaDhL8=;
        b=F5+WMvUmRENfITCkPlHn20VD6dZ9zgjhCvz5PvDKYcSrr4N0W0xKQdRnPv7uy1P2l8
         B2o+36MqD3GXGTSH076m5PWYFvb/8OBPs+OmvL0KTEiYztgLsC/oPRSteg8LhXwj7NY/
         asp47CFrSLVyobPEUfe2FCa53slYQ2zbufPcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IlOpNe06zparSPIP72bJPBkCaWq6A7cyq5H83KSPKHgQ+wD+4+ytyT7WuiOe0lV2PB
         JO/4WNrEtVMD9A6nhqdxQr+Epoa6k60ehx6Opf1/eGKsoybpIWeFXOkC/j7Xu6QV7iLF
         J92votO4Emy3Jz846Da7nXEMLx7TSJ2asc8FU=
Received: by 10.140.247.11 with SMTP id u11mr1740104rvh.37.1223161309673;
        Sat, 04 Oct 2008 16:01:49 -0700 (PDT)
Received: by 10.141.5.11 with HTTP; Sat, 4 Oct 2008 16:01:49 -0700 (PDT)
In-Reply-To: <loom.20081004T195935-879@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97484>

On Sat, Oct 4, 2008 at 2:07 PM, Mark Burton <markb@ordern.com> wrote:
>
> Hi,
>
> It's still early days for me and I haven't yet discovered how to ask git to list
> all the files in a tree that don't have pending modifications (staged or not). I
> have read about ls-files but it doesn't seem to offer that option. As far as I
> can tell, it can list the files known to git and the files that have been
> modified but not the difference between those sets.

You could manually construct the difference between the lists:

$ comm -3 <(git ls-files) <(git ls-files --modified)
