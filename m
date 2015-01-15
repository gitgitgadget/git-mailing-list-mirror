From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: Segmentation fault in git apply
Date: Thu, 15 Jan 2015 00:26:11 -0800
Message-ID: <99579252-EF8A-4DAF-A49D-2AC5627ED9E3@gmail.com>
References: <CAO2U3QjGUfnTRO_poS+=-MfE4aYGuWpVJTe20H-u=FgkVy-RYg@mail.gmail.com> <CAO2U3Qjn9o_eYayEMCC3S6DBr9kVH7mPL00QGrXAnV2iYRP-=A@mail.gmail.com> <CAO2U3Qj-Hg2tb72NgO6wb-aqAxFG7aga2ZDeZNDCPJzGtmHTAA@mail.gmail.com> <CAO2U3Qhd_DPP09BUyMr6NKUtOe4EQQ7G83BRg7MbtQXFPjKv8w@mail.gmail.com> <CAO2U3Qje-YwcV1d5BK_zZqrTki4AU=emdkUZzEEieRjmoQdmGg@mail.gmail.com> <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 09:26:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBfkx-0000IO-NO
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 09:26:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbbAOI0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 03:26:15 -0500
Received: from mail-pd0-f180.google.com ([209.85.192.180]:37711 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbAOI0O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 03:26:14 -0500
Received: by mail-pd0-f180.google.com with SMTP id fl12so14979239pdb.11
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 00:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=v/xpQFUb7MNi/IkGlMGmpobNWcgMJa11jT4XwQMOAeg=;
        b=BkrtgrE/LxRKrbubp9fHrCilyXDRVXl2jMbxAZKT5A6tX1X3DXyRmzF9CuqKcLP0Km
         TjupOKDlquOcmqPzIyY/jF0API2QRX7Kk2jkril2XEDlU+Vg8/bolWnfei0E0UjLNCvr
         K0Ez4l6yOKO4iJPit/JCWSvonsZWtaIpLwbs2ojD+TRVbqdaWeQqCgrvHl449nXC670k
         9xINd03b/RUIJ17VegSycaq0rWE8t/+gh7zGHFOtFHd7OxGWEYOHLJKB1WYHWVL2YKP2
         QKW/JeiHRtc08n4khM/hgB45a3gJ6BJug3MAjDGltcWPnN86m4xfkwYLLdWYEDeEGamP
         RR6A==
X-Received: by 10.68.68.237 with SMTP id z13mr2680599pbt.151.1421310373962;
        Thu, 15 Jan 2015 00:26:13 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id oh2sm835858pbb.61.2015.01.15.00.26.12
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 15 Jan 2015 00:26:13 -0800 (PST)
In-Reply-To: <CAO2U3Qi4TWZiNoOQVSW=Ycvp3bpBySZrCGmRLCbRJJes_n2Wkw@mail.gmail.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262467>

On Jan 14, 2015, at 11:09, Michael Blume wrote:
> On Wed, Jan 14, 2015 at 10:58 AM, Michael Blume  
> <blume.mike@gmail.com> wrote:
>> On Wed, Jan 14, 2015 at 10:48 AM, Michael Blume  
>> <blume.mike@gmail.com> wrote:
>>> On Wed, Jan 14, 2015 at 10:44 AM, Michael Blume <blume.mike@gmail.com 
>>> > wrote:
>>>> On Wed, Jan 14, 2015 at 10:40 AM, Michael Blume <blume.mike@gmail.com 
>>>> > wrote:
>>>>> On Wed, Jan 14, 2015 at 10:20 AM, Michael Blume <blume.mike@gmail.com 
>>>>> > wrote:
>>>>>> This is a mac with a fresh build of git from pu branch, commit  
>>>>>> 53b80d0.
>>>>>>
>>>>>> With my gitconfig looking like
>>>>>>
>>>>>> [user]
>>>>>>    email = blume.mike@gmail.com
>>>>>>    name = Michael Blume
>>>>>> [apply]
>>>>>>    whitespace = fix
>>>>>> [core]
>>>>>>    whitespace = fix,trailing-space,space-before-tab, tab-in- 
>>>>>> indent, tabwidth=4
>>>>>>
>>>>>> If I run
>>>>>> git clone git@github.com:MichaelBlume/clojure.git
>>>>>> cd clojure
>>>>>> git checkout origin/rebase-start
>>>>>> git rebase origin/rebase-base
>>>>>>
>>>>>> I get
[...]
>>>>>> Applying: CLJ-1295: Speed up dissoc on array-maps
>>>>>> Applying: some throwing
>>>>>> Applying: don't pass offset to ArrayChunk
>>>>>> Applying: make EMPTY accessible
>>>>>> Applying: add handy create methods
>>>>>> Applying: regenerate
>>>>>> Applying: regenerate
>>>>>> /Users/michael.blume/libexec/git-core/git-am: line 854: 92059
>>>>>> Segmentation fault: 11  git apply --index "$dotest/patch" > / 
>>>>>> dev/null
>>>>>> 2>&1

I can reproduce in a 64-bit v2.1.4 as well, but not in a 32-bit v2.1.4  
build.

My recipe is slightly different to facilitate automation:

cd /tmp
git clone git://github.com/MichaelBlume/clojure.git
cd clojure
git config user.email "blume.mike@gmail.com"
git config user.name "Michael Blume"
git config apply.whitespace fix
git config core.whitespace \
   "fix,trailing-space,space-before-tab, tab-in-indent, tabwidth=4"
git checkout origin/rebase-start
git rebase origin/rebase-base

Looks like v1.7.6.6 64-bit works okay.

Running git bisect run...

5782..2890..1445..722..361..179..91..44..23..13..7..3..1..0

And the winner is (first appearing in v1.8.2.2):

commit 250b3c6c992b3cb04e756eb33bed99442fc55193
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Mar 22 11:10:03 2013 -0700

     apply --whitespace=fix: avoid running over the postimage buffer

     Originally update-pre-post-images could assume that any whitespace
     fixing will make the result only shorter by unexpanding runs of
     leading SPs into HTs and removing trailing whitespaces at the end  
of
     lines.  Updating the post-image we read from the patch to match the
     actual result can be performed in-place under this assumption.
     These days, however, we have tab-in-indent (aka Python) rule whose
     result can be longer than the original, and we do need to allocate
     a larger buffer than the input and replace the result.

     Fortunately the support for lengthening rewrite was already added
     when we began supporting "match while ignoring whitespace
     differences" mode in 86c91f91794c (git apply: option to ignore
     whitespace differences, 2009-08-04).  We only need to correctly
     count the number of bytes necessary to hold the updated result and
     tell the function to allocate a new buffer.

     Signed-off-by: Junio C Hamano <gitster@pobox.com>

And just to confirm, building with 250b3c6c^ (which also happens to be  
v1.8.0.3) does not fail.

And the stack trace from the crash dump of a debug build of 250b3c6c is:

Thread 0 Crashed:
0   libSystem.B.dylib  0x00007fff8290242a szone_free + 1222
1   git                0x0000000100009fe9 apply_one_fragment + 2164  
(apply.c:2816)
2   git                0x000000010000a760 apply_fragments + 195  
(apply.c:2959)
3   git                0x000000010000b62d apply_data + 96 (apply.c:3340)
4   git                0x000000010000c0b1 check_patch + 869 (apply.c: 
3559)
5   git                0x000000010000c157 check_patch_list + 83  
(apply.c:3574)
6   git                0x000000010000dc70 apply_patch + 646 (apply.c: 
4189)
7   git                0x000000010000ea3a cmd_apply + 2700 (apply.c: 
4418)
8   git                0x0000000100001ae8 run_builtin + 402 (git.c:306)
9   git                0x0000000100001c9a handle_internal_command +  
181 (git.c:467)
10  git                0x0000000100001dab run_argv + 41 (git.c:516)
11  git                0x0000000100001ede main + 258 (git.c:588)
12  git                0x0000000100000ee8 start + 52

And the gdb backtrace from the core file:

#0  0x00007fff8290242a at szone_free + 1222
#1  0x0000000100009fe9 in apply_one_fragment (img=0x7fff5fbfe640,  
frag=0x100400a60, inaccurate_eof=0, ws_rule=3268, nth_fragment=1) at  
builtin/apply.c:2815
#2  0x000000010000a760 in apply_fragments (img=0x7fff5fbfe640,  
patch=0x1004005e0) at builtin/apply.c:2959
#3  0x000000010000b62d in apply_data (patch=0x1004005e0,  
st=0x7fff5fbfe6b0, ce=0x1004072e0) at builtin/apply.c:3340
#4  0x000000010000c0b1 in check_patch (patch=0x1004005e0) at builtin/ 
apply.c:3559
#5  0x000000010000c157 in check_patch_list (patch=0x1004005e0) at  
builtin/apply.c:3574
#6  0x000000010000dc70 in apply_patch (fd=3, filename=0x7fff5fbff33a "/ 
private/tmp/clojure/.git/rebase-apply/patch", options=0) at builtin/ 
apply.c:4189
#7  0x000000010000ea3a in cmd_apply (argc=1, argv=0x7fff5fbff178,  
prefix_=0x0) at builtin/apply.c:4418
#8  0x0000000100001ae8 in run_builtin (p=0x1001a7070, argc=3,  
argv=0x7fff5fbff178) at git.c:306
#9  0x0000000100001c9a in handle_internal_command (argc=3,  
argv=0x7fff5fbff178) at git.c:467
#10 0x0000000100001dab in run_argv (argcp=0x7fff5fbff13c,  
argv=0x7fff5fbff130) at git.c:513
#11 0x0000000100001ede in main (argc=3, argv=0x7fff5fbff178) at git.c: 
588

The crashing line at apply.c:2815 is:

   free(oldlines);

And oldlines appears to be valid (it has normal program text in it).

Running with various MallocCheckHeap and MallocErrorAbort settings  
leads to:

git(12926) malloc: *** error for object 0x10040be80: incorrect  
checksum for freed object - object was probably modified after being  
freed.

And a new backtrace from the core file:

#0  0x00007fff82962da6 at __kill + 10
#1  0x00007fff829c5af8 at szone_error + 476
#2  0x00007fff829c7218 at szone_check + 637
#3  0x00007fff829caaf8 at malloc_zone_check + 42
#4  0x00007fff829cb11d at internal_check + 14
#5  0x00007fff828fc939 at malloc_zone_malloc + 60
#6  0x00007fff828fc8e0 at malloc + 44
#7  0x0000000100131ae4 in xmalloc (size=47378) at wrapper.c:50
#8  0x000000010000950b in update_image (img=0x7fff5fbfe4a0,  
applied_pos=1569, preimage=0x7fff5fbfe340, postimage=0x7fff5fbfe310)  
at builtin/apply.c:2533
#9  0x0000000100009fa7 in apply_one_fragment (img=0x7fff5fbfe4a0,  
frag=0x100400a60, inaccurate_eof=0, ws_rule=3268, nth_fragment=1) at  
builtin/apply.c:2808
#10 0x000000010000a760 in apply_fragments (img=0x7fff5fbfe4a0,  
patch=0x1004005e0) at builtin/apply.c:2959
#11 0x000000010000b62d in apply_data (patch=0x1004005e0,  
st=0x7fff5fbfe510, ce=0x1004072e0) at builtin/apply.c:3340
#12 0x000000010000c0b1 in check_patch (patch=0x1004005e0) at builtin/ 
apply.c:3559
#13 0x000000010000c157 in check_patch_list (patch=0x1004005e0) at  
builtin/apply.c:3574
#14 0x000000010000dc70 in apply_patch (fd=9, filename=0x7fff5fbff1e2 "/ 
private/tmp/clojure/.git/rebase-apply/patch", options=0) at builtin/ 
apply.c:4189
#15 0x000000010000ea3a in cmd_apply (argc=1, argv=0x7fff5fbfefe0,  
prefix_=0x0) at builtin/apply.c:4418
#16 0x0000000100001ae8 in run_builtin (p=0x1001a7070, argc=3,  
argv=0x7fff5fbfefe0) at git.c:306
#17 0x0000000100001c9a in handle_internal_command (argc=3,  
argv=0x7fff5fbfefe0) at git.c:467
#18 0x0000000100001dab in run_argv (argcp=0x7fff5fbfef9c,  
argv=0x7fff5fbfef90) at git.c:513
#19 0x0000000100001ede in main (argc=3, argv=0x7fff5fbfefe0) at git.c: 
588

I looked at the code a bit, but a fix does not just jump out at me.   
 From the debug info it seems pretty clear that some memory's being  
stepped on.

-Kyle
