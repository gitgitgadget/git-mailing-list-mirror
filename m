From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2013, #07; Sun, 21)
Date: Mon, 22 Jul 2013 14:48:17 +0700
Message-ID: <CACsJy8BsiXL9P5Rd9QZzG5Rtyd=0ewBbFRLwbAyumgTWwjJd5A@mail.gmail.com>
References: <7vy58zozdk.fsf@alter.siamese.dyndns.org> <51ECDFFC.8000500@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jul 22 09:48:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1ArU-0007F1-LG
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 09:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756692Ab3GVHss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 03:48:48 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:39012 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513Ab3GVHss (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 03:48:48 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so7824819obc.13
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 00:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tfSOyyazt2BbVn71ucgGXwhAE/im/g/7uuML3Xro/Ow=;
        b=jja7N33a7j5BhumMlt4W4vK50GSiIlC6yI7V2xbF6pOTsdlRDxAx+1TYqH6+EQLCQA
         0AK5A9YCFdbsLSbxBhXtEDRfJGUKAjq3Fw2sDukb+lVIJR07x3qSgpae/e7wUTM1mgDT
         Io9IJNH0xGkadGIxCX5wlqdDlhPlN7Mny4OYBdYAXfaimMi0Yzwi7/B05ealQlDHrsob
         TaZZJ4UlW+3siy17F+gD//jV0xmzwnt2DfaGu8eUEldFdhd2hLvRWU5X7tqHHYyeAYk8
         fvPEHe1kzoStl3q7NtdxeuxriPHvY5BdWqwlIsuNcaREdPwwBB1DTPscL4OdMZtYWLBW
         yrHg==
X-Received: by 10.182.119.229 with SMTP id kx5mr2522196obb.23.1374479327454;
 Mon, 22 Jul 2013 00:48:47 -0700 (PDT)
Received: by 10.182.240.168 with HTTP; Mon, 22 Jul 2013 00:48:17 -0700 (PDT)
In-Reply-To: <51ECDFFC.8000500@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230965>

On Mon, Jul 22, 2013 at 2:32 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
> Am 22.07.2013 08:57, schrieb Junio C Hamano:
>> * jl/submodule-mv (2013-04-23) 5 commits
>>  . submodule.c: duplicate real_path's return value
>>  . rm: delete .gitmodules entry of submodules removed from the work tree
>>  . Teach mv to update the path entry in .gitmodules for moved submodules
>>  . Teach mv to move submodules using a gitfile
>>  . Teach mv to move submodules together with their work trees
>>
>>  "git mv A B" when moving a submodule A does "the right thing",
>>  inclusing relocating its working tree and adjusting the paths in
>>  the .gitmodules file.
>>
>>  Ejected from 'pu', as it conflicts with nd/magic-pathspec.
>
> So I'll base my upcoming re-roll on pu, right?

The conflicted part is the use of common_prefix. I think you might be
able to avoid the conflict by using quote.c:path_relative() instead of
common_prefix() and prepending "../" manually. Or not, I did not read
path_relative() carefully, nor your connect_work_tree_and_git_dir().
--
Duy
