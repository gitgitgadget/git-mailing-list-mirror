From: "Simon Strandgaard" <neoneye@gmail.com>
Subject: Re: bug: git-stash save and symbolic links
Date: Mon, 20 Oct 2008 17:32:32 +0200
Message-ID: <df1390cc0810200832i4fa974fx1d70ed489aa1be02@mail.gmail.com>
References: <df1390cc0810200134x68a8eb1fyc7f24650c8c9c5d3@mail.gmail.com>
	 <20081020151715.GA13553@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 00:01:51 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrwmP-0006FR-IN
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 17:34:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYJTPcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 11:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbYJTPce
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 11:32:34 -0400
Received: from el-out-1112.google.com ([209.85.162.181]:48223 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbYJTPcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 11:32:33 -0400
Received: by el-out-1112.google.com with SMTP id z25so398694ele.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2008 08:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YrJ5W8GVxg+htXBjvOO/9bw9UJFjK6pDnLFjoSREjJU=;
        b=Pj2FRSJsbLMkBMylyX/MkNqJHdaZraHVmNBCYZ5wGpV7AuWnNJsfLGfrjIJz003AP9
         3f87JxcL3cE4JtIYXDarjOryDH5p64LbTaI5gSLice2jo71/6ujz/2WoodV6sZoLSJLx
         ENtudnZHbDlG4EcQ1rszqFP2mOOKtoDYklLFQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=T7bvL3JtytEsefQiNKtgMmeZ6AepvzXpkuegv139u9tXOAYSO1cuX5/opxFPS0x93p
         ub2vpouMwLmr7MpHtt6+sXF5a9H+Zncx8FXUyOH6HOan69xPOVAf304kHyfXGR6VjWG4
         m2U1ZPwWSYcwWgBbXlpUt2As4eY3EMcLz4hzU=
Received: by 10.142.81.7 with SMTP id e7mr3124132wfb.320.1224516752068;
        Mon, 20 Oct 2008 08:32:32 -0700 (PDT)
Received: by 10.143.168.21 with HTTP; Mon, 20 Oct 2008 08:32:32 -0700 (PDT)
In-Reply-To: <20081020151715.GA13553@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98720>

On Mon, Oct 20, 2008 at 5:17 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 20, 2008 at 10:34:53AM +0200, Simon Strandgaard wrote:
[snip]
> What version of git are you running (though I tried a few different
> ones, and all passed my test)?


I have made some changes, so it can be reproduced

prompt> sh run.sh
Initialized empty Git repository in /Users/neoneye/Desktop/test/repo/.git/
Created initial commit a2a7d6f: one
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 file
before stash
fatal: Not a git repository
fatal: Not a git repository
fatal: Not a git repository
You do not have the initial commit yet

prompt> cat run.sh
rm -rf repo &&
rm -f linked &&
mkdir repo &&
   cd repo &&
     git init &&
     echo content >file &&
     git add file &&
     git commit -m one &&
     mkdir test &&
   cd .. &&
     ln -s repo/test linked &&
   cd linked &&
     echo cruft >>file &&
     echo before stash &&
     git stash &&
     echo after stash

prompt> pwd
/Users/neoneye/Desktop/test
prompt>


This is my computer

prompt> git --version
git version 1.5.6.2
prompt> uname -a
Darwin Macintosh.local 9.5.0 Darwin Kernel Version 9.5.0: Wed Sep  3
11:29:43 PDT 2008; root:xnu-1228.7.58~1/RELEASE_I386 i386
prompt>


-- 
Simon Strandgaard
http://toolboxapp.com/
