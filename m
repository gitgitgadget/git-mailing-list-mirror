X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: index manipulation quickref
Date: Tue, 12 Dec 2006 12:28:07 +0100
Message-ID: <8aa486160612120328x2ab64c78v6a6d5bc2a64caf26@mail.gmail.com>
References: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 12 Dec 2006 11:28:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cyv1LrR2df0a7un8Ib6oicH/WGSUDZSxdjVUBWiErM4M5K7o0M/M7hFWU+S5uoxXm0GBDOXQAcMDBXZhK+vOWpXMiNolJv49bVDHI/F6djGdiEtJUg8S+ai7MM5lznYmguzSk3uuuMVzuow8R9Iuqh5ZY7fI/67wo8KdeBmXolA=
In-Reply-To: <fcaeb9bf0612120257p35dc9483ob65eea9ae21b5f7b@mail.gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34081>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu5nx-0000Qg-39 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 12:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751062AbWLLL2J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 06:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWLLL2J
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 06:28:09 -0500
Received: from wx-out-0506.google.com ([66.249.82.225]:9166 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1751062AbWLLL2I (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec
 2006 06:28:08 -0500
Received: by wx-out-0506.google.com with SMTP id h27so1868951wxd for
 <git@vger.kernel.org>; Tue, 12 Dec 2006 03:28:08 -0800 (PST)
Received: by 10.70.59.20 with SMTP id h20mr14522244wxa.1165922888039; Tue, 12
 Dec 2006 03:28:08 -0800 (PST)
Received: by 10.70.46.19 with HTTP; Tue, 12 Dec 2006 03:28:07 -0800 (PST)
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Sender: git-owner@vger.kernel.org

On 12/12/06, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Hi,
>
> I'm trying to collect all operations related to index from user
> perspective and corresponding commands. The list may be put to git
> wiki if people think it can help newbies:

Cool. But for "index-newbies" not "git-newbies" :)

We could add (if exists) the porcelain-ish equivalent as:

update file content to index:
  git update-index file
  git add file (the development version)

add a file to index:
  git update-index --add file
  git add file

delete a file from index:
  git update-index --remove [--force-remove] file
  git rm file

read a tree to index:
  git read-tree treeish
  git reset commit-ish # It changes also the HEAD

read a file from a tree to index:
  git ls-tree treeish file | git update-index --index-info --stdin
  N/A

copy a file from index to workdir:
  git checkout-index file
  git checkout file

refresh index:
  git update-index --refresh
  git status # It does more things

copy entire index to workdir:
  git checkout-index
  git checkout -f

output a file from index to stdout:
  git cat-file blob :file (or :n:file, where n=0,1,2,3 are the unmerged stage)
  ??

list files in index:
  git ls-files
  ??

compare index and workdir file listing:
  git ls-files (with lots of options here)
  git status?

diff between workdir and index:
  git diff-files
  git diff

diff between index and a tree:
  git diff-index --cached treeish
  git diff --cached treeish

