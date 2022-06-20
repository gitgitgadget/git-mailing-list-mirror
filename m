Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74048C433EF
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 11:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241787AbiFTLOy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241769AbiFTLOc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 07:14:32 -0400
Received: from fallback24.mail.ru (fallback24.m.smailru.net [94.100.187.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880891834E
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 04:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dIuD08NIEuwJFyhmuWN8c9jFXphG0iHPMwYVU+Pi3RM=;
        t=1655723606;x=1656329006; 
        b=aM0Ary7WIRDG5PAYSN5p3NyAmZTlwthX63lJc2tgL3PHjW8oyPx3NbWL0D06pi1SOljgxZaoGDLGbWRKMtJ9Vo6YZimGgdJDD6FEiGltALihIWZDZd/XNZNAp4r6WWzM6IX8pOUPjkDPPWDzL/NaOA0x7qu6eWi54mHuZYV2dyo=;
Received: from [10.161.16.37] (port=52900 helo=smtp63.i.mail.ru)
        by fallback24.m.smailru.net with esmtp (envelope-from <kostix@bswap.ru>)
        id 1o3FLD-0007xL-Gz
        for git@vger.kernel.org; Mon, 20 Jun 2022 14:13:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bswap.ru; s=mailru;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dIuD08NIEuwJFyhmuWN8c9jFXphG0iHPMwYVU+Pi3RM=;
        t=1655723591;x=1656328991; 
        b=nPe5c3NJJLlCpe+qzhyYZrCDmxHQOi150ivfhCALdK9UK4e83khPDoTXrrXwSHaziChmr0owPhjleW33DcB9M3fCATiX8eCZkoNsiGc0ZKOMGZ7r2A46ZmD+0xjqBFAWAGmEQOkOScKVvt42zslaKCbIlHMX59l/Cw3wYRV7k4c=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <kostix@bswap.ru>)
        id 1o3FKY-0005f2-WB; Mon, 20 Jun 2022 14:12:31 +0300
Date:   Mon, 20 Jun 2022 14:12:30 +0300
From:   Konstantin Khomoutov <kostix@bswap.ru>
To:     Fabrice Creuzot <code@luigifab.fr>
Cc:     git@vger.kernel.org
Subject: Re: git a/xyz or b/xyz
Message-ID: <20220620111230.ck7nkouzkviidtcu@carbon>
References: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4f40821-8592-1a35-8b60-219fd7e29e9f@luigifab.fr>
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD97D44297578DBEB86157A728CB9AF912FB29B9D39C83553BE182A05F53808504053199449EE31847EA426DD2F9E2087AEB274A281D69DC568AA2B889CC3AB7033
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE795530B80AF2ADB7BEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637CF20B9B7F5DD35A68638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D89CE4E7E860FF2056285A0EACB9F6BDEA117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC292D688DDAD4E7BC389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8ED96AA85C75E140D117882F4460429728AD0CFFFB425014E868A13BD56FB6657D81D268191BDAD3DC09775C1D3CA48CF15D748DBC68C49F3BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C0329BA3038C0950A5D36D5E8D9A59859A8B69DDE31049AE272CF76E601842F6C81A1F004C906525384307823802FF610243DF43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7C468D16C903838CAB43847C11F186F3C59DAA53EE0834AAEE
X-8FC586DF: 6EFBBC1D9D64D975
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E1421815240C68AEAEBFF17866D6147AF826D89CE4E7E860FF2056285A0EACB9F6BDEAF972CCD2F8FE1EF1CFC4036BBF6A4EA9B11811A4A51E3B0915E2725BA614EAEA1EF972C1F679AE1C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D341E08D7EE1804B76377B1807375E5803A95631B8F24F7C0A8F305D6FBBC0AA8CE9FB353950A0652AE1D7E09C32AA3244CFFBF33F0652A3F2D289FE32A6BF1297B795D98D676DD64D0729B2BEF169E0186
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZjKQTVo6KSVQmKXNx6P+kQ==
X-Mailru-Sender: 641179478317D3F0421D0BEF39CFD138D5E75666D5858282BCE9F3BF526A92E2F3C1C20947204A4E13BA5AC085B0DF3CFD8FF98A8691EE7BAAB64A3C2C77197FCA12F3F80FA6A2FFE7D80B0F635B57EC5FEEDEB644C299C0ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B47AE4952871AAFFF6F04C84B37B83C1BF56CA13782AC7446F049FFFDB7839CE9EED9ACFAFD6525E1F6C5B5E489694B7C0151362BECDE9AA26A4BED3613C178E62
X-7FA49CB5: 0D63561A33F958A5093D819DF3284595844F3FBFC8FECB6A81FFF32FBDDB9C1F8941B15DA834481FA18204E546F3947C6FF1B927F95F3316F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637006720155ACF5028389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063776C4598447C51BFFD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CC1948A84299AD5C643847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 9604B64F49C60606AD91A466A1DEF99B296C473AB1E14218ACAA24C523BFAB347866D6147AF826D8A8A1BB6AD300BB4642A371AFFBEDD7B4F972CCD2F8FE1EF1CFC4036BBF6A4EA9B11811A4A51E3B0915E2725BA614EAEA1EF972C1F679AE1C
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojZjKQTVo6KSXQXMnCN/dSKQ==
X-Mailru-MI: 8000000000000800
X-Mras: Ok
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 18, 2022 at 12:45:30PM +0200, Fabrice Creuzot wrote:

> When we are reading a "git diff", all paths are prefixed with "a/" and "b/".
> Example:
> 
> diff --git a/xyz
> index 4aa4b5230..1c2b8b69e 100644
> --- a/xyz
> +++ b/xyz
> @@ -1,7 +1,7 @@
> 
> 
> With my terminal, I double click on the path to select the full path for
> copy.
> 
> Then, when I paste: "git log a/xyz",
>  git says: unknown revision or path not in the working tree
> 
> Ok, I need to remove the "a/" or "b/".
> But, is git can understand that "a/xyz" is "xyz" because "a/xyz" does not
> exist?

A quick answer: pass `git diff` the "--no-prefix" command-line option to
suppress generation of these prefixes.


A bit of historical context.

Please note that `git diff` - at least by default - generates its output using
the format known as "unified diff" which was invented an implemented way
before Git was concieved [1]. Quite probably on your system you have access to
the two command line tools - `diff` and `patch`, - one of which generates
diffs by comparing two files, and another one being able to update a file
using a patch information produced by the former.

The diff format records the pathnames of the files compared when the patch
data was generated.

Now consider that a patch file can describe changes to apply to any set of
files. In order to achieve this, the format has to name the files to be used.

Now consider that the diff format can use used for two conceptually slightly
different purposes:

 - A patch file in this format can describe a set of "concrete" changes.

   Say, you pass a patch file to someone, they just run `patch` on it and
   that tool patches a set of files no matter where it was run from.

 - A patch file in this format can describe a set of changes intended to
   be applied to a particular state of a file or a set of files, possibly
   comprising a hierarchy, located anywhere in the target filesystem.
   
   A good example is a source tree of a software project: a user can fetch
   a tarball with a software project and unpack it everywhere they wish.
   They then should be able to apply a patch file to that unpacked tree.

Note that in the former case the names of the names of the files listed in a
patch file may not share even the smallest common prefix while in the second
case they will have the same prefix, and the prefix may not even be needed at
all.

Historically the patch files to be used in the second case were generated by
running a tool like `diff` against the two hierarchies of files: a source,
unmodified directory, and the copy of that directly with the necessary
modifications. That is, you'd run something like

  $ diff -u srcdir modified > changes.patch

and because of that the generated patch file would naturally contain file
names starting with "srcdir/" and "modified/" prefixes.

The tool to apply patch files, `patch`, has a command-line option "-p" (for
"prefix") which can be used to strip the specified number of prefix
directories from the names of the files when applying a patch file. So to
apply a patch generated by comparing two directory hierarchy you'd routinely
pass "-p1" to that tool, like in

  $ cd srcdir
  $ patch -p1 < changes.patch


OK, so you can now note that `git diff` is different from the classical patch
maniputation tools in that its operation is somewhat virtualized: by default
it generates a patch describing the set of differences between the work tree
and the index, and can be told to generate a patch between sets of files in
named revisions and so on. So there's no two directories physically existing
on the file system and so `git diff` generates fake prefixes.

Exactly why it does so by default, I don't know, but I suppose it's just to be
in line with the classical use case explained above which was in widespread
use before Git even existed.

1. https://en.wikipedia.org/wiki/Diff#Unified_format

