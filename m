From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] git-p4: Use -m when running p4 changes
Date: Mon, 20 Apr 2015 10:54:36 -0700
Message-ID: <xmqq7ft6n0rn.fsf@gitster.dls.corp.google.com>
References: <CALM2SnY4GZDSYOjLmDqdq9SgGGywRO2A3XU3639E_0JAh-2P5A@mail.gmail.com>
	<1429542020-11121-1-git-send-email-lex@lexspoon.org>
	<CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lex Spoon <lex@lexspoon.org>, Git Users <git@vger.kernel.org>,
	Pete Wyckoff <pw@padd.com>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Apr 20 19:54:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkFuB-0007gK-0E
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 19:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbbDTRyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 13:54:41 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63601 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751024AbbDTRyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 13:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4019A49BEF;
	Mon, 20 Apr 2015 13:54:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mskL5Tg6YE2FWU+Ga8yJDq4AxKU=; b=TBoQkN
	eyml3R8wjXFbF5wF3+eYanUQwvFuCpHyVBMr7zK8Ns14X8w/Gw8N03hi/EaGxugT
	luxtXmBXs+15VQF9ThBa2Fc6LmTHpExqpd3grABWKVBO49/PXiiegQuBQ2rWny4s
	osB7W4H5zC39DTf/UlW0X3rQuFwL4l8STZ2l4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ryBbMvdAdXQuEL+NY3mVWJN/XV32afP6
	37vmlkm/ZGiRtB0Y9Ldga1UyGAEIjdXpGsYubAn97437RqOsjd4HuAsjQZsUk45m
	oynOetP6ZKnd7soo/gT0sCmAVmbwCETO8m35PRZl3NYH8Ps6Qhk6kj8JEJP+xsxM
	ppf45Vo1+1g=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 38E3249BED;
	Mon, 20 Apr 2015 13:54:40 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1C6CD49BEB;
	Mon, 20 Apr 2015 13:54:39 -0400 (EDT)
In-Reply-To: <CAE5ih79BLm1LbZersZeOxShq=W4X5xaPHE1cDwctA5cJOSLRJA@mail.gmail.com>
	(Luke Diamand's message of "Mon, 20 Apr 2015 16:15:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 509189EA-E786-11E4-8FFF-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267479>

Luke Diamand <luke@diamand.org> writes:

> Sorry - could you resubmit your patch (PATCHv4 it will be) with this
> change squashed in please? It will make life much easier, especially
> for Junio!

Thanks for caring, but this seems to be a full patch to replace v3.

It was sent with your Reviewed-by already in, but I'd tentatively
remove that line while queuing it to 'pu' and ask you to double
check if the patch makes sense (and after your "yes, it does", I'd
add the Reviewed-by back).

Thanks.

>
> Thanks!
> Luke
>
>
> On 20 April 2015 at 16:00, Lex Spoon <lex@lexspoon.org> wrote:
>> Simply running "p4 changes" on a large branch can
>> result in a "too many rows scanned" error from the
>> Perforce server. It is better to use a sequence
>> of smaller calls to "p4 changes", using the "-m"
>> option to limit the size of each call.
>>
>> Signed-off-by: Lex Spoon <lex@lexspoon.org>
>> Reviewed-by: Junio C Hamano <gitster@pobox.com>
>> Reviewed-by: Luke Diamand <luke@diamand.org>
>> ---
>> Updated to avoid the crash Luke pointed out.
>> All t98* tests pass now except for t9814,
>> which is already failing on master for some reason.
>>
>>  Documentation/git-p4.txt | 17 ++++++++++---
>>  git-p4.py                | 52 ++++++++++++++++++++++++++++++---------
>>  t/t9818-git-p4-block.sh  | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 119 insertions(+), 14 deletions(-)
>>  create mode 100755 t/t9818-git-p4-block.sh
>>
>> diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
>> index a1664b9..82aa5d6 100644
>> --- a/Documentation/git-p4.txt
>> +++ b/Documentation/git-p4.txt
>> @@ -225,9 +225,20 @@ Git repository:
>>         they can find the p4 branches in refs/heads.
>>
>>  --max-changes <n>::
>> -       Limit the number of imported changes to 'n'.  Useful to
>> -       limit the amount of history when using the '@all' p4 revision
>> -       specifier.
>> +       Import at most 'n' changes, rather than the entire range of
>> +       changes included in the given revision specifier. A typical
>> +       usage would be use '@all' as the revision specifier, but then
>> +       to use '--max-changes 1000' to import only the last 1000
>> +       revisions rather than the entire revision history.
>> +
>> +--changes-block-size <n>::
>> +       The internal block size to use when converting a revision
>> +       specifier such as '@all' into a list of specific change
>> +       numbers. Instead of using a single call to 'p4 changes' to
>> +       find the full list of changes for the conversion, there are a
>> +       sequence of calls to 'p4 changes -m', each of which requests
>> +       one block of changes of the given size. The default block size
>> +       is 500, which should usually be suitable.
>>
>>  --keep-path::
>>         The mapping of file names from the p4 depot path to Git, by
>> diff --git a/git-p4.py b/git-p4.py
>> index 549022e..e28033f 100755
>> --- a/git-p4.py
>> +++ b/git-p4.py
>> @@ -740,17 +740,43 @@ def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent
>>  def originP4BranchesExist():
>>          return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
>>
>> -def p4ChangesForPaths(depotPaths, changeRange):
>> +def p4ChangesForPaths(depotPaths, changeRange, block_size):
>>      assert depotPaths
>> -    cmd = ['changes']
>> -    for p in depotPaths:
>> -        cmd += ["%s...%s" % (p, changeRange)]
>> -    output = p4_read_pipe_lines(cmd)
>> +    assert block_size
>> +
>> +    # Parse the change range into start and end
>> +    if changeRange is None or changeRange == '':
>> +        changeStart = '@1'
>> +        changeEnd = '#head'
>> +    else:
>> +        parts = changeRange.split(',')
>> +        assert len(parts) == 2
>> +        changeStart = parts[0]
>> +        changeEnd = parts[1]
>>
>> +    # Accumulate change numbers in a dictionary to avoid duplicates
>>      changes = {}
>> -    for line in output:
>> -        changeNum = int(line.split(" ")[1])
>> -        changes[changeNum] = True
>> +
>> +    for p in depotPaths:
>> +        # Retrieve changes a block at a time, to prevent running
>> +        # into a MaxScanRows error from the server.
>> +        start = changeStart
>> +        end = changeEnd
>> +        get_another_block = True
>> +        while get_another_block:
>> +            new_changes = []
>> +            cmd = ['changes']
>> +            cmd += ['-m', str(block_size)]
>> +            cmd += ["%s...%s,%s" % (p, start, end)]
>> +            for line in p4_read_pipe_lines(cmd):
>> +                changeNum = int(line.split(" ")[1])
>> +                new_changes.append(changeNum)
>> +                changes[changeNum] = True
>> +            if len(new_changes) == block_size:
>> +                get_another_block = True
>> +                end = '@' + str(min(new_changes))
>> +            else:
>> +                get_another_block = False
>>
>>      changelist = changes.keys()
>>      changelist.sort()
>> @@ -1911,7 +1937,10 @@ class P4Sync(Command, P4UserMap):
>>                  optparse.make_option("--import-labels", dest="importLabels", action="store_true"),
>>                  optparse.make_option("--import-local", dest="importIntoRemotes", action="store_false",
>>                                       help="Import into refs/heads/ , not refs/remotes"),
>> -                optparse.make_option("--max-changes", dest="maxChanges"),
>> +                optparse.make_option("--max-changes", dest="maxChanges",
>> +                                     help="Maximum number of changes to import"),
>> +                optparse.make_option("--changes-block-size", dest="changes_block_size", type="int",
>> +                                     help="Internal block size to use when iteratively calling p4 changes"),
>>                  optparse.make_option("--keep-path", dest="keepRepoPath", action='store_true',
>>                                       help="Keep entire BRANCH/DIR/SUBDIR prefix during import"),
>>                  optparse.make_option("--use-client-spec", dest="useClientSpec", action='store_true',
>> @@ -1940,6 +1969,7 @@ class P4Sync(Command, P4UserMap):
>>          self.syncWithOrigin = True
>>          self.importIntoRemotes = True
>>          self.maxChanges = ""
>> +        self.changes_block_size = 500
>>          self.keepRepoPath = False
>>          self.depotPaths = None
>>          self.p4BranchesInGit = []
>> @@ -2586,7 +2616,7 @@ class P4Sync(Command, P4UserMap):
>>          branchPrefix = self.depotPaths[0] + branch + "/"
>>          range = "@1,%s" % maxChange
>>          #print "prefix" + branchPrefix
>> -        changes = p4ChangesForPaths([branchPrefix], range)
>> +        changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
>>          if len(changes) <= 0:
>>              return False
>>          firstChange = changes[0]
>> @@ -3002,7 +3032,7 @@ class P4Sync(Command, P4UserMap):
>>                  if self.verbose:
>>                      print "Getting p4 changes for %s...%s" % (', '.join(self.depotPaths),
>>                                                                self.changeRange)
>> -                changes = p4ChangesForPaths(self.depotPaths, self.changeRange)
>> +                changes = p4ChangesForPaths(self.depotPaths, self.changeRange, self.changes_block_size)
>>
>>                  if len(self.maxChanges) > 0:
>>                      changes = changes[:min(int(self.maxChanges), len(changes))]
>> diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
>> new file mode 100755
>> index 0000000..153b20a
>> --- /dev/null
>> +++ b/t/t9818-git-p4-block.sh
>> @@ -0,0 +1,64 @@
>> +#!/bin/sh
>> +
>> +test_description='git p4 fetching changes in multiple blocks'
>> +
>> +. ./lib-git-p4.sh
>> +
>> +test_expect_success 'start p4d' '
>> +       start_p4d
>> +'
>> +
>> +test_expect_success 'Create a repo with ~100 changes' '
>> +       (
>> +               cd "$cli" &&
>> +               >file.txt &&
>> +               p4 add file.txt &&
>> +               p4 submit -d "Add file.txt" &&
>> +               for i in $(test_seq 0 9)
>> +               do
>> +                       >outer$i.txt &&
>> +                       p4 add outer$i.txt &&
>> +                       p4 submit -d "Adding outer$i.txt" &&
>> +                       for j in $(test_seq 0 9)
>> +                       do
>> +                               p4 edit file.txt &&
>> +                               echo $i$j >file.txt &&
>> +                               p4 submit -d "Commit $i$j" || exit
>> +                       done || exit
>> +               done
>> +       )
>> +'
>> +
>> +test_expect_success 'Clone the repo' '
>> +       git p4 clone --dest="$git" --changes-block-size=10 --verbose //depot@all
>> +'
>> +
>> +test_expect_success 'All files are present' '
>> +       echo file.txt >expected &&
>> +       test_write_lines outer0.txt outer1.txt outer2.txt outer3.txt outer4.txt >>expected &&
>> +       test_write_lines outer5.txt outer6.txt outer7.txt outer8.txt outer9.txt >>expected &&
>> +       ls "$git" >current &&
>> +       test_cmp expected current
>> +'
>> +
>> +test_expect_success 'file.txt is correct' '
>> +       echo 99 >expected &&
>> +       test_cmp expected "$git/file.txt"
>> +'
>> +
>> +test_expect_success 'Correct number of commits' '
>> +       (cd "$git" && git log --oneline) >log &&
>> +       test_line_count = 111 log
>> +'
>> +
>> +test_expect_success 'Previous version of file.txt is correct' '
>> +       (cd "$git" && git checkout HEAD^^) &&
>> +       echo 97 >expected &&
>> +       test_cmp expected "$git/file.txt"
>> +'
>> +
>> +test_expect_success 'kill p4d' '
>> +       kill_p4d
>> +'
>> +
>> +test_done
>> --
>> 1.9.1
>>
