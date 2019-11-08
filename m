Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51F081F454
	for <e@80x24.org>; Fri,  8 Nov 2019 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbfKHUyb (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 15:54:31 -0500
Received: from mout.gmx.com ([74.208.4.200]:39111 "EHLO mout.gmx.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfKHUyb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 15:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.com;
        s=dbd5af2cbaf7; t=1573246467;
        bh=/WmfxZllKBmUfj2R/nGPvVySZ2io45lA7I1iirLJPlI=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sfnK9cGWh7RmrlMMdtg083RXH8NoGUUY8Qubv/eRpeHvfwrFODiirpkZIpBYOCzOh
         raxwC3KlVm/ukam+h7uKXsZ95V5XY7mjTMoBYmM5LfaTJy6HHMaHn/YlbZidzGGUyK
         OHOWPMSnSOo5l6bX/4WHA7VtuhjAAQe5fADYG7a4=
X-UI-Sender-Class: 214d933f-fd2f-45c7-a636-f5d79ae31a79
Received: from [192.168.43.24] ([92.69.35.197]) by mail.gmx.com (mrgmxus001
 [74.208.5.15]) with ESMTPSA (Nemesis) id 0McmWd-1iBEkR1ROD-00Huvj; Fri, 08
 Nov 2019 21:54:27 +0100
Subject: Re: [BUG/FEATURE] Git pushing and fetching many more objects than
 strictly required
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
References: <bc43c70e-861d-425d-d7c4-73a3e25b7383@cheerful.com>
 <20191108184723.246596-1-jonathantanmy@google.com>
From:   Paul van Loon <nospam@cheerful.com>
Message-ID: <e537d298-6431-c36a-2fc3-e41baa10d0a3@cheerful.com>
Date:   Fri, 8 Nov 2019 21:54:02 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191108184723.246596-1-jonathantanmy@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OzLbSLusKzxbb94I+haahjsA5YRatxXASV4n/CbdMLT2JlC9TPP
 KksbRerXp6RrFyy6rFs4IMzRkBbpuZANq2ZlOxV7LFFfN6nL9+JaBtx0mktJ+uY8rod8UfJ
 5dKPQR+GggfBos19oTyPXgLxeCS+eM/tJgqLtT0DpZOBg2AtcuOJ4iC65LxqGJFVE3dPbdQ
 TUKeBIY9cC3IYtfB7VbEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JApvkT3cJmk=:9MMl1lcj3NlQB5IaDwEAL4
 9+MS/GT/hk4qypDRUDWbPpd9zWkTe1Caew3gmv2TRP2e3+uddq3KCW5HRCoyoaxakjdiwqQnM
 V11vP2c5ax9ap1OvwE8GxTqJPlzgpE+f29hN5dy4D0gmo4pALOFrtQoxD0G5uduvVSKkyXK3X
 ytHAaRljy+dLTpitNYAmPg5fmjBjmskfu3HnJnSeDuYXgxJDkwhJK8q+VDQSRh8vSnqkIDGLT
 eWVoMrfKsjm8aeoXmJ/EUt5ykZIyiLNiRVlA9A/hAtHQgP+d7CHhVefwC3mxFIRY9GoIxmkBs
 +V1ScrUvo7Qxbhryio1m8n31v1KvfioKptIGm1qvRYV567+Hm4KU08lYGklGsfLA76/e3hfOn
 jR3M/mZy/rM0gXE9T4zx+TuZpNG+EnzqoaOs6231JT/8otCToLcLo51FCM3YrIL4y7VnFPKhN
 KDQ8Ls6hGxmCoLmBrfOYcvqHyjlazBqP/H3QDWnd4J9lt9Ih68S21zp0PICMjNw0i546WkNqZ
 BI9+47As19K/FRSaHgx5CZ9+KcuCYGvv6oRW/VIes/oer5OeusxtXQIP1HYUAPSUcRWiaBjGe
 MgaO92toshyTHx7rSA/1dAU4KhCgx+Kf5rBaCb570EDyCIPMs3i5T4MVfK8aoquo+NaxGlzcH
 5ZLyir+G+EUSJHWs3faSeToYEIVS7EHM9UjRf8LWE43uXlsvzOXAcID026SvXezYcSSHkgTM9
 daOx7TXfHN9JMHQUyIT6et3wCj/zSQguQITGdfpUeyy2E9/XUxSIZA7G2nVZ03sXK82gXztXH
 bJQAU+FJMa6YLmgHC1jdNe/xGpjBf5HYkHhNh5DF5U5ldHJCgVWAjs8OjJKVNGrlMgvpIlHV0
 MkUP/O/5sY5YQSBJK5xot838oGpjMKb7Ye0Q68urwKX5LxiEWeA6I06F5h4zCYJXOCSIYK38L
 U2wQ7iDkysVuCg2u26sX3CnegTvnHTwv2Nw2R94W2D6C818hkKJt0JsbQutkR9P4JvG/e0d2o
 S+sasXQIh3sDEXp3Z9OR44zhA0skQ7Awr+EWXrd0wSwpDT0NflKZ4b5p3di0HvELicfaoK/mz
 HHZb4AGNbWCs0KmJp8ebFzSNxSap9tZFdUk5mfNrBAGi428jNdm953qTuXSJKWEEzJG7rNtxV
 6OG5iOt5sTacf0/PHnWU0JWRfylbhXONEWjephFgZ9sqeA7pYgWbj1aEBsRSupUqT+VSA9tes
 lNCm7N2ucLptRsJ2gYr9LE5kcBCQptgYL4Ug3fhV3lA2MGblersu1C2LhcaE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-08 19:47, Jonathan Tan wrote:
>> $ git fetch --all
>> Fetching origin
>> remote: Enumerating objects: 29507, done.
>> remote: Counting objects: 100% (29507/29507), done.
>> remote: Compressing objects: 100% (33/33), done.
>> remote: Total 53914 (delta 29478), reused 29500 (delta 29471), pack-reu=
sed 24407
>> Receiving objects: 100% (53914/53914), 31.90 MiB | 111.00 KiB/s, done.
>> Resolving deltas: 100% (42462/42462), completed with 7382 local objects=
.
>> --
>>
>> $ git push -v origin 'refs/replace/*:refs/replace/*'
>> Pushing to XXXX
>> Enumerating objects: 2681, done.
>> Counting objects: 100% (2681/2681), done.
>> Delta compression using up to 8 threads
>> Compressing objects: 100% (1965/1965), done.
>> Writing objects: 100% (2582/2582), 1.96 MiB | 1024 bytes/s, done.
>> Total 2582 (delta 95), reused 1446 (delta 58)
>> remote: Resolving deltas: 100% (95/95), completed with 33 local objects=
.
>> To XXXX
>>  * [new branch]            refs/replace/XXXX -> refs/replace/XXXX
>
> Could you verify that refs/replace/XXXX (or one of its close ancestors)
> was fetched by the "git fetch --all" command? "--all" fetches all
> remotes, not all refs.

No, it was not fetched. HOWEVER, the ONLY thing the replace commit (1 sing=
le object) does is point to an existing parent object. No other new object=
s are referenced.
Those 'ancestor' objects were all fetched.

Paul

