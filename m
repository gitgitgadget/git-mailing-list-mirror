From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 5/5] builtin/clone: support submodule groups
Date: Wed, 25 Nov 2015 20:50:21 +0100
Message-ID: <565610FD.9070303@web.de>
References: <1448415139-23675-1-git-send-email-sbeller@google.com>
 <1448415139-23675-6-git-send-email-sbeller@google.com>
 <5655F544.6050003@web.de>
 <CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 20:50:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1g5c-000507-S4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 20:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbbKYTuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 14:50:51 -0500
Received: from mout.web.de ([212.227.15.14]:62104 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbbKYTut (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 14:50:49 -0500
Received: from [192.168.178.41] ([79.211.124.82]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Le4fk-1agXf12Sku-00prG5; Wed, 25 Nov 2015 20:50:23
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZrBRo9dfU=p8-bgvSpp=SSiXQHZGm7iCQ=9v0f_f_-aQ@mail.gmail.com>
X-Provags-ID: V03:K0:S6Z0MVbL/EbnHQmKR3rqV7KM3OFkQ9WhFrRrzaE3G3I+Uq9bQjP
 otgEog/benXA5g9SZmrkgBxaX4z6SwHk8JG/Pzx/ma5RXfnlfymxVAld9/w24WW6lCcwRCU
 MpHA88m81Wo2nnvPBh2Xzm4rRGwOUIVGlp06ht0BkpCRIgslWJuGdlCHl4jZ2ExXt2cE4ae
 /OGdnMpMBzGfldCNQbhKQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1wbAFEttAm0=:6hqnqNNxnxjXXwKhbLWyEb
 CGLC69cJN2Vn47SyaW0QLm9XQ7GDTkgm7nft/+nQIW6cops8xewJlQGRoyIptd40Ag5vElpFG
 /bsL5OVttk5ttmcb7o7qxBUkRZacuRlbu8tZ4EGkqiWT8PQS2R7scNryxfwBv9J8ASXdZDyfS
 RSDUOYQHPkTpdJw/j7rY04f1ULqRLAbw/Y+83depiaUjkhDMzlLs7vHbu+9nOiMkgQGO7TndO
 UVv8jeQz7nz7up2AYUMsQ2im02I68uRwLiTJs1cN+5nkFviy19chSkHriipV48ljal9lhEifJ
 D9vEiGAV1LhSehO7WIFgg9MMkTazdThl2cFa4tQTy1mR58yvEKoYPQgpXyyS6pk0ahJ/QR/SA
 foNO9hQeG15vAwFonAeBzNRAIiNQV1stuc0Trw8sCeRWgsIUjgFsnE0OBOT5QaYu0fIT0vWK1
 lF4+BUViVu/uEVZK0XnJu2DyJXP/X2gQnxxj+Zn7JaFAmBQK8VEdy8+qwsgKksU4ANHdHM4Oc
 JKyHW5zbasdNfnnW0sNLCK2zl/cvYOilLBTestki/HMrmOiWcue82xDj77VwAIcDr8o/gf3Ys
 qY50vqMtuXfYC6a4OSBBR/y1M7y2vyM27ISGoyX7Wjvb5yWj26jq4RFl7t5W5eEo/Tst98rcr
 B+JiiLO4ktn9cQCe1MQGBdkmfJ6dkgECnjOyg6VVxpJxwVe/Q26dciXXrhuUS2W8mNyFlcVuQ
 zJ07QqhQqPiVa/69m/R9D0Q2xjLyaoOyqi1kP9F3KJ9AFbo52n020cHwSnCq1zMv/0PhOyYs 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281734>

Am 25.11.2015 um 19:08 schrieb Stefan Beller:
> On Wed, Nov 25, 2015 at 9:52 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> +--group::
>>> +       After the clone is created, all submodules which are part of the
>>> +       group are cloned. This option can be given multiple times to
>>> specify
>>> +       different groups.
>>
>>
>> Ah, that answers my question in my response to the cover letter ;-)
>>
>>> This option will imply automatic submodule
>>> +       updates for the groups by setting `submodule.update=groups`.
>>
>>
>> Please don't. The per-submodule update setting configures how a
>> submodule has to be updated, adding a global one with a completely
>> different meaning (what submodules should be updated?) is confusing.
>> Why not "submodule.groups=<groups>"?
>
> The documentation is out of date :/ as I was churning through lots of ideas,
> so we do have a config submodule.groups=<groups> by now, but the
> documentation is wrong.

Thanks for explaining, I did not look at the code very closely so
far so I missed that.

>>
>>> +       The group selection will be passed on recursively, i.e. if a
>>> submodule
>>> +       is cloned because of group membership, its submodules will
>>> +       be cloned according to group membership, too. If a submodule is
>>> +       not cloned however, its submodules are not evaluated for group
>>> +       membership.
>>
>>
>> What do you mean by the last sentence? Did the clone fail? Then you
>> cannot update the submodule anyway ...
>
> Consider nested submodules:
>
>      A: superproject containing
>          B: which contains
>              C.
>
> If you clone A with group <C-but-not-B> you won't get C as we do not traverse
> the submodules of B, as we don't clone B. Maybe it's obvious?

Maybe yes. Everything about submodule C is configured in B's
.gitmodules file, not in A's. So you cannot find submodule C
in A's .gitmodules (and it thus cannot be in one of A's submodule
groups either). And if cloning B fails, you have no .gitmodules
file to get the URL of C to clone it from in the first place. So
I think the concept 'group <C-but-not-B>' doesn't make any sense
when C is a submodule of B.

>>> @@ -864,6 +876,21 @@ int cmd_clone(int argc, const char **argv, const char
>>> *prefix)
>>>                  option_no_checkout = 1;
>>>          }
>>>
>>> +       if (option_recursive && submodule_groups.nr > 0)
>>> +               die(_("submodule groups and recursive flag are
>>> incompatible"));
>>
>>
>> Me thinks this contradicts your description of the --group option
>> in the man page. I don't see why such a restriction would make
>> sense, what incompatibility are you trying to avoid here? Maybe
>> we need another submodule-specific setting to tell update what
>> groups to use inside that submodule?
>
> So you want something like
>      "In the top level respect the groups, but recursively get all of them"?

Nope, only those that are chosen by the groups.

> My thinking is that groups are implying recursive, whereas recursive implies
> "all groups", so a git clone --group <half-the-submodules> --recursive
> makes not much sense to me as it begs the question, what does --recursive
> mean?

Groups are only about what submodules to update and have nothing to
do with recursion. It might make sense to imply recursion, but that's
just because that should have been the default for submodules from day
one. Recursion and groups are orthogonal, the first is about what to
do inside the submodules (carry on or not?) and the latter is about
what to do in the superproject (shall I update this submodule?).

 > Probably recurse into all submodules which are implied by the group
> <half-the-submodules>.

Yep. We also do not recurse into those submodules having set their
update setting to "none", so we do not do that for submodules not
in any chosen group either.

 > And then get all the nested submodules. But in case
> you use the grouping feature, you could just mark the nested submodules with
> groups, too?

Not in the top superproject. In a submodule you can specify new groups
for its sub-submodules, but these will in most cases be different from
those of the superproject.

Imagine I have this really cool Metaproject which contains the Android
superproject as a submodule. Those two will define different groups,
and when recursing into the android submodule I need to choose from the
Android specific groups. So my Metaproject's .gitmodules could look like
this:

[submodule "android"]
         path = android
         url = git://...
         groups = default,mobile
         subgroups = devel

"groups" tells git what superproject groups the android submodule
belongs to, and "subgroups" tells git what android submodules are
to be checked out when running recursively into it. If you do not
configure "subgroups", the whole android submodule is updated when
one of the groups "default" or "mobile" is chosen in the superproject.
