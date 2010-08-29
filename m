From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 06/13] transport-helper: update ref status after
 push with export
Date: Sun, 29 Aug 2010 17:25:54 -0500
Message-ID: <20100829222554.GJ1890@burratino>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-7-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 00:27:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpqLn-00030J-B9
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 00:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753908Ab0H2W1j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Aug 2010 18:27:39 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34658 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753357Ab0H2W1i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Aug 2010 18:27:38 -0400
Received: by gwj17 with SMTP id 17so1784182gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 15:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=T1noyaQ8GAY+xDgtxrqaEQAONfSi1VwBZUcP6rSP9ww=;
        b=Lb7g2e4UZlRMjufZmS8F90aCgjJZX2BBGe2igrT8ZBEUITd2sJfZhDgyUpEKlV2b3x
         akUHNnOnQQSQFtGEfqg4qXnvgWImjNjGrEMrpV1UVlbVxGQ8ebhY0m28QSEAVcjLt0uW
         1DLUcmq4j/ntNZaC7zDIt7VcLn8X6vv4mlgYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=R2tNzxu/i892XpIYlK6XOlniDno5uM2CiTQkkSnCxd6NAF33AiaoMghX9dINWRDwcQ
         3fOYkB+s1Hs1r0zRCC3D3HM9nmM7dERlYHmwHTGbt5CqfaFxkuXTy4bPsBwbzEuY5tJr
         FxDT6BQ2QcDH4u1FAaDi8hHyLdTpHnlbg4hpc=
Received: by 10.151.7.17 with SMTP id k17mr2071307ybi.284.1283120857760;
        Sun, 29 Aug 2010 15:27:37 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id r3sm6653389ibk.13.2010.08.29.15.27.37
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Aug 2010 15:27:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283053540-27042-7-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154729>

Sverre Rabbelier wrote:

>   Obviously the testgit helper shouldn't just print 'ok' for master,
>   but it demonstrates the idea.

For those who (like me) wondered what it should do:

	When the push is complete, outputs one or more ok <dst> or
	error <dst> <why>?  lines to indicate success or failure of
	each pushed ref. The status report output is terminated by a
	blank line. The option field <why> may be quoted in a C style
	string if it contains an LF.

So I guess testgit should be getting this information from the
result of non_local.push().
