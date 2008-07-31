From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: linking libgit.a in C++ projects
Date: Thu, 31 Jul 2008 14:55:26 -0400
Message-ID: <32541b130807311155v50ee6ddaha1bba2f56e9bd61d@mail.gmail.com>
References: <ac9f0f090807310253v1d97e2a1n4ddf34aa4fdc79f0@mail.gmail.com>
	 <4891B872.3040707@panasas.com> <20080731183732.GA7598@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Boaz Harrosh" <bharrosh@panasas.com>, cte <cestreich@gmail.com>,
	git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:56:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdKA-0001sV-HY
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757526AbYGaSzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755218AbYGaSza
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:55:30 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:44211 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757604AbYGaSz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:55:27 -0400
Received: by yw-out-2324.google.com with SMTP id 9so420928ywe.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2008 11:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=c9/H8cJugsICq3lIcf0CTPz1BgsdvESHOE0vboVGvWo=;
        b=t0XoT3AWue3UELCuNV4BBlMEvSsXrrRhUgzigI7Ou7V54w6IrpJbjP1Mu8Nbi4IwlM
         iv3Fz3E5h/QjQnbyAQH3OSikO2yBWXJ/E25QFkbwWWkP/H3LdKbCAcU0xtYh+39/vaQI
         8x36sQJwGX7qDrtOOXEIxsjevb24dmeVQfwy8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=BWC14UzpwpzyYQBb7wuix+giaQzozwdbiR7uBIbR5HTODhOiH/w117Glg1f2mBQYsP
         bqDuYdMIFDoxtBEl+BdTGk6TGc2LYudMzHAnWOLz+BWr17JleDK/+/9qAz+YUW7t3sne
         uijSKxLDe9Pw4J1PuR1QXNmPI3mH/+y2nYMXA=
Received: by 10.151.113.5 with SMTP id q5mr1720690ybm.148.1217530526018;
        Thu, 31 Jul 2008 11:55:26 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 31 Jul 2008 11:55:26 -0700 (PDT)
In-Reply-To: <20080731183732.GA7598@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90963>

On 7/31/08, Alex Riesen <raa.lkml@gmail.com> wrote:
> Boaz Harrosh, Thu, Jul 31, 2008 15:04:50 +0200:
> > Produce a C file and header that defines some stable API to your
>  > GUI application, that does not expose any git internal headers.
>  > Then compile that, say git_api.c, with C compiler in Makefile
>  > and extern "C" link that file to your C++ application. This will
>  > completely insulate you from any git code.
>
> no, it wont. He still have to resolve name conflicts at the link time.

Language keywords (as opposed to function names) like 'new' and
'typename' are definitely not exported to the object files.  Moreover,
function parameter names aren't either.

Avery
