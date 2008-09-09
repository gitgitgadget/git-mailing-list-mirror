From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Revert behavior [Was: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain]
Date: Tue, 9 Sep 2008 15:38:13 +0200
Message-ID: <200809091538.13961.jnareb@gmail.com>
References: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Govind Salinas" <govind@sophiasuchtig.com>,
	"Steven Walter" <stevenrwalter@gmail.com>, git@vger.kernel.org
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 15:39:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kd3RK-0001yQ-H7
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 15:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753081AbYIINiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 09:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbYIINiT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 09:38:19 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:43692 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653AbYIINiT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 09:38:19 -0400
Received: by gxk9 with SMTP id 9so10398518gxk.13
        for <git@vger.kernel.org>; Tue, 09 Sep 2008 06:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=U1pbivJP/H4a264OdejF3PGlf9h2ejwzPFLjizcKhtQ=;
        b=af5Q3OQPY2e2mCdq/zAym1JBf3G0BZWcK4GICSnp1oVUyZgkZzZVi7r7YqZcr3boiz
         ApMX/PeVb5UfoShojh1qF0NYEthy9V15ZQIOufvkgbgcw/nm2AQ+XuH9gjQIACUoZvam
         RJpWTsQa4WM3fg9oWWE25F9O4LEl89N8XeWoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ANXRueRz9sp+F0YkYzsl9kbE3kH7b7a8dLwAWtjER6V5HrfNdULEA1E42id/AmnD46
         OyRYnfR8HAmlZcbrMj+BpfoS2/qj1VuRPbmDK0XmmGraItf6Vk2msf0zMdIiTmPUceKE
         MJopV+ZQ8ztFgwXIi7eWwzswLAi4zRcyauBgk=
Received: by 10.103.23.4 with SMTP id a4mr11253317muj.17.1220967496750;
        Tue, 09 Sep 2008 06:38:16 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.239.219])
        by mx.google.com with ESMTPS id i5sm24855932mue.11.2008.09.09.06.38.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Sep 2008 06:38:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <51419b2c0809090626p2196c590j7569fb471e470f0d@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95384>

Elijah Newren wrote:
> On Mon, Sep 8, 2008 at 10:25 PM, Govind Salinas
> <govind@sophiasuchtig.com> wrote:
> > On Mon, Sep 8, 2008 at 8:05 PM, Steven Walter <stevenrwalter@gmail.com> wrote:
> 
> > I had some very different ideas along the lines of reducing the number of
> > commands (where the commands do something similar just DWIM rather
> > than force me to remember or read docs on different commands), making
> > commands look similar to commands from other SCMs (revert should do
> > what it does for me in all the other SCMs that I have used, which is to
> > checkout the HEAD copy into the working directory)
> 
> Your description of revert in various systems isn't quite accurate; it
> isn't necessarily HEAD, since most systems (at least bzr and hg) can
> also revert files to revisions earlier than HEAD.  In fact, questions
> of how to do that have come up several times on this list, so you
> wouldn't want to exclude that case.  Also, the revert behavior of git
> (minus perhaps the default auto-commit) comes in pretty handy too
> sometimes, and I can't easily find it in other systems (I suspect many
> just drop back to diff + patch to handle the case that git provides).
[...]

By the way, I think the fact that in different SCMs meaning of
"$scm revert" and of "$scm reset" differs widely caused Mercurial
to adopt "hg backout" for creating a commit which reverts changes
(cherry-pick -R), and "hg rollback" to undo last commit.

-- 
Jakub Narebski
Poland
