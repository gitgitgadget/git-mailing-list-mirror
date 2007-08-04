From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Terminology question about remote branches.
Date: Sat, 4 Aug 2007 16:35:09 +0200
Message-ID: <8c5c35580708040735l54d1b9c7i40cd80d7d11e2961@mail.gmail.com>
References: <854pjfin68.fsf@lola.goethe.zz> <85tzrfh3yg.fsf@lola.goethe.zz>
	 <8c5c35580708040607ya186edcg89fbc90587b64d68@mail.gmail.com>
	 <85k5sbh129.fsf@lola.goethe.zz>
	 <8c5c35580708040703w44781498t7396588a3f8c81c8@mail.gmail.com>
	 <854pjfgzit.fsf@lola.goethe.zz> <85y7grfkbe.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, git@vger.kernel.org
To: "David Kastrup" <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Aug 04 16:35:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHKip-0004vD-NX
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 16:35:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957AbXHDOfM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 10:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbXHDOfM
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 10:35:12 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:3337 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbXHDOfK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 10:35:10 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1180599wah
        for <git@vger.kernel.org>; Sat, 04 Aug 2007 07:35:10 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GOrQn00Hr7gkIurXr85LgO75UiPbqPYDdA8gbiGjlnCyxhGlrEO6DFuY5PKYhT7w3QJPSAGFlpiydpEQsEb02TktN7ZYmT48cDw6b+tvo7catQP2gSSnbPox1oCwq1AxUF1eFXvntnGft23xgj+MJ7WIgwWt2KGZ9M7UuTgTmb4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eJeR0ikMLdWCzDb/uEjP9JrIpbpJiyOWWB88iR2Lt1jmDt91Iq/f5/5A5MuOLFFjWBxTpNsJsWcauU/+Pov58tsvKqIx8IiBFa+HG6Ablbac3mkYBVDYxBS/dr724ijYekwG73a/AZ5yoqUWcmU7vXi+2ZMXZmOCpi/SvWs9H9M=
Received: by 10.114.151.13 with SMTP id y13mr3988387wad.1186238109781;
        Sat, 04 Aug 2007 07:35:09 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Sat, 4 Aug 2007 07:35:09 -0700 (PDT)
In-Reply-To: <85y7grfkbe.fsf@lola.goethe.zz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54858>

On 8/4/07, David Kastrup <dak@gnu.org> wrote:
> Can we get merge conflicts
> with a remote tracking branch, too?  Namely when the remote branch
> messed with its history, rebased/reverted stuff?

No, since the "fetch" line in .git/config is prefixed by '+', which
gets translated to the '-f' option for 'git-fetch'.

And this was probably the primary reason for refs/remotes/* in the
first place: you have a namespace in which there is no chance for
'git-fetch' to overwrite local changes (ancient git had no such
namespace).

-- 
larsh
