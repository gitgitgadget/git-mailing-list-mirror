Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FB7220899
	for <e@80x24.org>; Sun, 30 Jul 2017 13:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbdG3Nnt (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jul 2017 09:43:49 -0400
Received: from mout.web.de ([212.227.17.12]:55672 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdG3Nns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jul 2017 09:43:48 -0400
Received: from [192.168.178.41] ([79.211.104.161]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M6DuI-1dnBE30DqE-00yCQz; Sun, 30
 Jul 2017 15:43:29 +0200
Subject: Re: [PATCH 02/15] submodule: don't use submodule_from_name
To:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170725213928.125998-3-bmwill@google.com>
 <CAGZ79kY9Pdk5C8=k-AQpCPwo3q9Jzfg9A93UQxGyyf_OyrMS_Q@mail.gmail.com>
 <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com>
From:   Jens Lehmann <Jens.Lehmann@web.de>
Message-ID: <a3650c9a-fa42-09e6-efcd-f912d5ffc042@web.de>
Date:   Sun, 30 Jul 2017 15:43:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <xmqqwp6uq56s.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VEhjuW4JsPmKmV5twXglNgGjIdLSIvMHu5GZv3R7vIWMAPoiQA2
 A3/WMEHsimzAc6FwvgebCQj3zkgxhPPvbStqVGg6ywgPhgS5Z2xtd4KfkHIrUrsLyJ/MLaw
 5u+OUXRHx3j/RMUJreEybJh0QW8aYItTBaB2KJS90Ps7KD83YL/hNOq56DTkvn3aMyRw24I
 Yo+Ojo1WfTEdjDMSpaRGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Bar10JA0uNI=:T1ttLjUkoZA40fpu3raqAL
 3yuuNRBLJP9rsCN6RiFBY9wmEVXD60gr+MzjQOa9quTFFYIcDKxsSLra76traKCJ15j3UpBJz
 ys6AeHlCuWOq8MdTYAk+BsOx2HWaP+KoOMSnBVlxRDTRzbyY/u0cVNGaoPIOGDkIktmYw5tGi
 hG6ow45tqqu2VWK0rwZPTcI7qtLlELpTbF4PoeITmxyTYlJ5uIc35+NP9RGjtaA4xlyiOWgd1
 VpGU6ff0enKVvP6E8LbJJ7R0LEDaC72WwcMfxtH8jtAxojiLsQD2jOfG6xqu1ZIv0QzDvz8i/
 GMzty3xiEvm8WHRefZehMFtUCznOd9XIyqm0CcV+7VseGrIVmXjzOkHLmfTd+VzcAqWaLqKqN
 R5I5iRFTJp3p3o6D67eKsTHqvpJgmnQBRe4GNMxyBuoB8XbXOr03BhoMGFnjkew/lvPNSlncG
 pgPNufv0GubRASx2+ZFcxDbbGCbh0860IY07S6KF/eericuNweDpbtUe6Qak4tmyelCdlYRgi
 QfRDzDNeQj9GrfYKvPkBpX1manIkAsNknUEQqRa2q2U6GCchuKg6L4CeVB03m+6Z1UC0BKO7S
 0vHyJ3YL18y7uNpT5w/oDhg1fJJSi8pMcB1KV+tlRpluYeOR7wz+5B611UH545fFZG0S0V5ZW
 h9Y+umeax2L3fhgpZprPc2OsWxu83+uS32ZB8eN59E0RPh9+8EsSOOVkHwYTgr2upKXoNQB80
 YJ6GCpr5ooM8zKvaIVbhjbJK+jMKs1l/QvDm1KHdhXSYgdOtj26CawavBSVF/F94bg4sPEFgs
 kjgBi9wfueo7zWMzZhF2gbZtQa1GQsO2IgAnGpFCyMx7aMPoUk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.07.2017 um 23:06 schrieb Junio C Hamano:
> Stefan Beller <sbeller@google.com> writes:
> 
>> Rereading the archives, there was quite some discussion on the design
>> of these patches, but these lines of code did not get any attention
>>
>>      https://public-inbox.org/git/4CDB3063.5010801@web.de/
>>
>> I cc'd Jens in the hope of him having a good memory why he
>> wrote the code that way. :)
> 
> Thanks for digging.  I wouldn't be surprised if this were a fallback
> to help a broken entry in .gitmodules that lack .path variable, but
> we shouldn't be sweeping the problem under the rug like that.

Sorry to disappoint you ;-) I added this in 7dce19d374 because
submodule by path lookup back then only parsed the checked out
.gitmodules file. So looking for it by name was a good guess to
fetch a new submodule that wasn't present in the current HEAD's
.gitmodules, as the path is used as the default name in "git
submodule add".

The refactoring in 851e18c385 could and should have removed that
because since then we use the .gitmodules path to name mapping
of the fetched commit.

> I wonder if we should barf loudly if there shouldn't be a submodule
> at that path, i.e.
> 
> 	if (!submodule)
> 		die("there is no submodule defined for path '%s'"...);
> 
> though.

Not sure if you want to die() or just issue a warning(), but yes.
