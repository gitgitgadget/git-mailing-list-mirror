Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DC151F42F
	for <e@80x24.org>; Mon, 27 Aug 2018 12:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbeH0QCO (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:02:14 -0400
Received: from mout.gmx.net ([212.227.17.20]:57795 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726374AbeH0QCO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:02:14 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M1zFf-1fdp2c323X-00u12u; Mon, 27
 Aug 2018 14:15:41 +0200
Date:   Mon, 27 Aug 2018 14:15:40 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Pratik Karki <predatoramigo@gmail.com>, git@vger.kernel.org,
        christian.couder@gmail.com, sbeller@google.com,
        alban.gruin@gmail.com
Subject: Re: [PATCH 03/11] builtin rebase: handle the pre-rebase hook (and
 add --no-verify)
In-Reply-To: <xmqqwot0fydp.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808271412140.73@tvgsbejvaqbjf.bet>
References: <20180808134830.19949-1-predatoramigo@gmail.com> <20180808134830.19949-4-predatoramigo@gmail.com> <xmqqwot0fydp.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8DcEv27Bms0G72oex0Sz7BYB8ESDwZ/410d2mTQj0DUyMt4IpdJ
 B3v/blnDkH7Wo4IErt+d+Cm/rx3JRr/FERPLB+TSkG0Lnnif5wA6tiksnxx8dB81iOiCK2U
 bopqVIpJRsB+uWQoQza12Uqq/Y5f4rbh915zIStCUmuEY/jvmlhq6gegSDzJHiYiLBH5TRZ
 ++48r7SUHU9B2dRI0JuFQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:av5rW9ikSbk=:rFXjqE7fYZLsZ2aipM3R+C
 4L8VtqooZIQvv3gqo+aJJLryqlZUQvXWfvsBhyle+Hap7cLxUYmcoil3T9hNO9Y0sqc4mnVxU
 /HSmEh9a3ruk3ugy2bV8uZsLJUT39V/+5BW8yAjnw0CIlAulyeE6vHkSEmfZaBYrP7jzbbVoj
 L/G+9c6K6U09LdQDCLtDkYovv2PdZIlSWOHxe5T4iqVQyPcetPTy3gZ29EpPMfz0EJTXn4uR7
 ND1cfalxUTNJL4xJQlANScg2y/SzJqJlWdNR1oZcQd+v6lw+gzQ3T9zH+8NTfXB9pIURwON54
 BIho6W68jTGzkSZgBs4WG9UKEJrQfH0tpfbcwCCnDNLGbliZXLW7RSubg+OsmNOIGS5Yp0OPq
 R05kRHD8iSv3wyTHEIm1YqBbVETiddN1NbOH/DBATsdHardN06H39iF9eXD1lRoItf0BKsEIV
 RNXfrKLHfk6hp34WvxdPTXi8f1fx4GPzTTfHwtvc9EPAnRa5ioIXize6ZIy+hMt47W4SauZn2
 N9XNQONc8DcTQzbw741vGIOac1D89Vi2L0rv9pQpIHr2U+weDM0gMY4QPNBe8oguNBBI1QCIz
 H7sfv2FxFA1UGjiEehKesdkqLDDXw1unMD7idV8zTTCGcvQDiFDuVnuLow8+r03WwY/yIUpIR
 IBd/KUQYWw+WJ2f4lDONWharLdy58jjjw5HE76tNZoFiffSNda8ySlu4f7K5TP1WOcdUl70SJ
 pohB3JcQPc9NVRf/PnxeFW4x6no6Vnsw7kTowp1SvYT3zjXgNdZvL7aGgBkMrxJalWjkMBfRX
 bZTQdSH
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Aug 2018, Junio C Hamano wrote:

> Pratik Karki <predatoramigo@gmail.com> writes:
> 
> > This commit converts the equivalent part of the shell script
> > `git-legacy-rebase.sh` to run the pre-rebase hook (unless disabled), and
> > to interrupt the rebase with error if the hook fails.
> >
> > Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
> > ---
> 
> Introduction of upstream_arg in this step looked a bit
> surprising, but the hook invocation is the only thing that uses it,
> so it is understandable.

Yep, that's literally all that `upstream_arg` is used for:

$ git grep upstream_arg v2.19.0-rc0
v2.19.0-rc0:git-rebase.sh:      upstream_arg="$upstream_name"
v2.19.0-rc0:git-rebase.sh:      upstream_arg=--root
v2.19.0-rc0:git-rebase.sh:run_pre_rebase_hook "$upstream_arg" "$@"

> "rebase: handle the re-rebase hook and --no-verify" would have been
> sufficient, without "add" or parentheses.

Fixed.

> > diff --git a/builtin/rebase.c b/builtin/rebase.c
> > index 38c496dd10..b79f9b0a9f 100644
> > --- a/builtin/rebase.c
> > +++ b/builtin/rebase.c
> > @@ -317,6 +319,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
> >  		OPT_STRING(0, "onto", &options.onto_name,
> >  			   N_("revision"),
> >  			   N_("rebase onto given branch instead of upstream")),
> > +		OPT_BOOL(0, "no-verify", &ok_to_skip_pre_rebase,
> > +			 N_("allow pre-rebase hook to run")),
> 
> Do we need to catch "--no-no-verify" ourselves with NONEG bit, or is
> this sufficient to tell parse_options() machinery to take care of
> it?

I just issued

	$ ./git rebase --verify --no-no-verify --xyz

and it showed

	error: unknown option `xyz'
	[... usage ...]

I vaguely remembered that the parse_options() machinery special-cases
"no-" prefixes, and my test seems to confirm it.

Holler if you want a more in-depth analysis.

Ciao,
Dscho
