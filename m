From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-filter-branch.txt: mention absolute path for scripts
 in --tree-filter
Date: Mon, 15 Mar 2010 12:57:49 +0100
Message-ID: <4B9E20BD.3090705@viscovery.net>
References: <87vdcy7zyu.fsf@jondo.cante.net> <4B9DFE36.3010707@viscovery.net> <87k4td95xm.fsf@jondo.cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 12:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr8vo-0006sd-LU
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 12:58:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936162Ab0COL5y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 07:57:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:31435 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936136Ab0COL5w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 07:57:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nr8vd-0003I8-P0; Mon, 15 Mar 2010 12:57:50 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7C6171660F;
	Mon, 15 Mar 2010 12:57:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <87k4td95xm.fsf@jondo.cante.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142206>

Jari Aalto schrieb:
> J6t:
>> Your choice of words is ambiguous: The --tree-filter is not the name of a
>> shell script, but rather the shell script itself; the example you gave is
>> just a shell script that happens to run only a shell on a file whose name
>> must be specified as an absolute path.
> 
> Full context was:
> 
>     --tree-filter <command>::
>             This is the filter for rewriting the tree and its contents.
>             The argument is evaluated in shell with the working
>             directory set to the root of the checked out tree.  The new tree
>             is then used as-is (new files are auto-added, disappeared files
>             are auto-removed - neither .gitignore files nor any other ignore
>             rules *HAVE ANY EFFECT*!).
>     +
>     In case the <command> is a shell script, provide an absolute path.
>     An example: --tree-filter 'sh /path/to/filter.sh'

I am complaining that you say "In case the <command> is a shell
script...".  There are no other cases; <command> is always a shell script.

What you meant to say is: "If you have your filter written down in a
separate shell script, you must invoke it using an absolute path, for
example, --tree-filter '/path/to/filter.sh'".

>> But doesn't the recommendation to use absolute paths apply not only to
>> --tree-filters, but
>>
>> - to all filters;
>>
>> - to all references to external files that the filters make.
> 
> I don't know.

It was a rethoric question. The hint about paths to files outside the
working directory should go to the general description of filters.

>     cd <gir repo>
>     git filter-branch  --tree-filter "sh $(pwd)/filter.sh" HEAD
> 
> And that didn't work quit either. Script was run, but paths weren't no
> longer relative to the "working dir" I was cd'd to:
> 
>     rm  file \
>         dir/file \
>         dir/file \
>         ..

I don't understand what you are trying to say, and I don't understand why
it helped to run

  git filter-branch  --tree-filter "sh /the/git/repo/filter.sh" HEAD

when the above did not work - from filter-branch's POV there is simply no
difference between the two invocations.

-- Hannes

PS: Please keep Cc list.
