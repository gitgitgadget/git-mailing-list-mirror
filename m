Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1418320370
	for <e@80x24.org>; Thu,  5 Oct 2017 19:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbdJETlX (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 15:41:23 -0400
Received: from mout.web.de ([217.72.192.78]:59199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbdJETlW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 15:41:22 -0400
Received: from [192.168.178.36] ([91.20.57.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHC8-1dvoIV2ghE-004Wyo; Thu, 05
 Oct 2017 21:41:15 +0200
Subject: Re: [PATCH] fsck: check results of lookup_blob() and lookup_tree()
 for NULL
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Martin Koegler <martin.koegler@chello.at>
References: <20171003102215.9952-1-szeder.dev@gmail.com>
 <19a08fb1-2fb3-f368-772b-36646a179975@web.de>
 <54f5877b-a143-11c2-d8f6-ff28ed9e7e38@web.de>
 <xmqqh8vfftp7.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <1cf044ae-ae3f-4d44-3aac-b5cc6584de1e@web.de>
Date:   Thu, 5 Oct 2017 21:41:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqh8vfftp7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:kcV2PpipKM+4/75xm3uDS2eGQbJjL/bKIkZBkx3c+GWSf15kX4h
 K5Zi43BRIley8rt4wsz5Ky1yGpQC9yC2fwf06X7PClQHTvpJZGa6x5js39T4XYZ/R3/OVYu
 HT1AlRcxyOwmiHFCAioe7VqveIx+aFaGFGodb6GQaJFHZMhsNwMeAc7txaMVFTxh7oxHRV+
 +t5qAsCA+nAjXzAtoXqZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WFA0hvTMOs8=:276kV0KdGycXELCIcGnMkd
 xdogm4ydAOmfhrROKP7+PGZoK37tf/0SIWsbgrMf0YczpxwGf4jQJo00Ze2y5dwtq/9DjSa+z
 I2/CchYKd7/HbMXxZTzacIiLzCrf5fDmFVEfPNPEFCQSzrNfnK/tps7OEQ5qLZCEawugTujy+
 Q4AW2ijKc6pd0EisWQ/BsXjoNyxE9KJzVV9yV8o95Vg6VOXH7NRJ47nJehlGi1dmBelVL099f
 Jg5S/53F0IpdbE5EuzLJ4lfciYZRHOcDDMO4IaSY+q+Kn+V5Cokt3brRtQqDCh33/TQyylhKg
 V5xUUtFQKwmZFgtfMKCyHtMb+AlsTZwmvcafcrEy350FtYnXAkSfKVR2dJmJnTugtgBcuLdG/
 GuqPNrk7c8aZAlm5HaNHkv1SU6BoMmOk1TOGXAcDJX8FYOCZ1UHAlZE3yngFROEFfwJa5COWO
 qbyGMqidlIZY6YMlkr+HDXq8VTaqd9uMXrmd67rmiKgfhACjMLCkyhmCoMsX1zoJtJCPXaI0f
 aYb5y14TMXt0WJphl+YT9y8yV4SWhKjKenISjJl7BEmisEt8UXYIeZiU7dx0VGajiK3HrXvvV
 l5wS1n2bV6VcVwASeGcjo2cBEzNEi2xunWSwZcKI8FdxE2QtV3MsqINsi55zCShgGhHXtlVhG
 /U3S/tlvLCMiPWAfWnblydhCnQElvF0d/Ptco/yyA7R7yNPulXyMR2QCwnnid9LpG4jHrhmxI
 E1PM6k3uL9RtU7JzaajYOVJM+mxrNVK0QdMPEOfoAt6TjNLgkd1GCqK2/PNmTeWjWatDIUoF0
 uGlo6wvbmU3KkNMZtOFw53ds9G+Seu86QvkYNrEt3PF1awOJts=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.2017 um 06:00 schrieb Junio C Hamano:
> René Scharfe <l.s.r@web.de> writes:
>> lookup_blob() and lookup_tree() can return NULL if they find an object
>> of an unexpected type.  Error out of fsck_walk_tree() in that case, like
>> we do when encountering a bad file mode.  An error message is already
>> shown by object_as_type(), which gets called by the lookup functions.
> 
> The result from options->walk() is checked, and among the callbacks
> that are assigned to the .walk field:
> 
>   - mark_object() in builtin/fsck.c gives its own error message to diagnose broken link
>     and returns 1;
> 
>   - mark_used() in builtin/fsck.c silently returns 1;
> 
>   - mark_link() in builtin/index-pack.c does the same; and
> 
>   - check_object() in builtin/unpack-objects.c does the same,
> 
> when they see a NULL object.
> 
> This patch may avoid the "unexpected behaviour" coming from
> expecting that &((struct tree *)NULL)->object == NULL the current
> code does, but it also changes the behaviour.  The loop used to
> diagnose a fishy entry in the tree we are walking, and kept checking
> the remaining entries in the tree.  You now immediately return, not
> seeing if the later entries in the tree are good and losing objects
> that are referenced by these entries as dangling.
> 
> I am not sure if this is a good change.  I suspect that the "bad
> mode" handling should be made less severe instead.

Makes sense.  Replacement patch coming up.  I'll pass on the mode
handling change, though (at least for now).

René
