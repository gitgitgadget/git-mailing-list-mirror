Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D747320984
	for <e@80x24.org>; Mon, 12 Sep 2016 11:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758057AbcILL6L (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Sep 2016 07:58:11 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36386 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755984AbcILL6K (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2016 07:58:10 -0400
Received: by mail-wm0-f41.google.com with SMTP id b187so131844832wme.1
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KJdTtCpA+Rqwj6aIm4kiC+Rnm5pzosTSkCFhDltSZcs=;
        b=hM+JOT5LdR2J3D6MC53d2u9h7Od/ZquRtVylh3XE03bnrNNo1wwheYJ3we9PsWTKmy
         RBbXEVdurdFU+nwsC8bZfant9tpp7aPdM3Z4g+UCUqSaXmPuZFhSzQAgLQoKBDDfQKa4
         JDc6Fd+tVMP3rEfkz/IPl1os5BxcRqVOczp04Nd2SyJEYoB+fujnHNFoMUDvwEKeQ7yh
         d3jfDhKJwTBgoeyfP/FEIpeapYYnqJe/zxhsPN8G6sHnZ7pXgpP3pfRw1ptsrnvLBd4q
         srRbsjP3aOJtEiLIB1Sov9mZicVcQBMnkPk6R8QPNxQHAVwSKlGWPmO5p7as+Vd2uTXn
         FMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KJdTtCpA+Rqwj6aIm4kiC+Rnm5pzosTSkCFhDltSZcs=;
        b=fnGwDBAn1k0xKTmFpAPZ8UeiEycOOhar4sk/pB1XSnJYTJ+V61yRJyK7TzXUuHuhEc
         O5wN9k3rO0njdtteCCCy28NNhjdnN8NHL84hk+oAbJrIUBCdPQGK4DnF7J9oUAExlNUM
         gp0wukuzHnz+pEFmwNs4z/TqMTc80jvMkB5kL738jOl/gyRQLpcFd9R0IC/h+FRbjlA9
         bpoeksa5ipAH0ItfWriYwGGVnG7jYdZugreixvqG1JrOE3HoqpWSh0AlmdHlCD+2mPWh
         ThK71JgAjkZ1HY7j7mvfRamPeirsvAFxrHoOoB3RRJUz94KyG0/I7FgGf4Ic8so3BSAW
         G/FA==
X-Gm-Message-State: AE9vXwMEYiCXsM9Ptczxp5EgS4FbjN1CZqGAM1nGWiltBX26vg74KSjPF9438Ef74/hr5Q==
X-Received: by 10.194.20.65 with SMTP id l1mr17226278wje.71.1473681488901;
        Mon, 12 Sep 2016 04:58:08 -0700 (PDT)
Received: from [172.31.96.158] ([91.231.145.254])
        by smtp.gmail.com with ESMTPSA id q139sm17515399wmb.18.2016.09.12.04.58.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 04:58:08 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 10/10] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20160910062919.GB11001@tb-raspi>
Date:   Mon, 12 Sep 2016 11:49:15 +0200
Cc:     Git Mailing List <git@vger.kernel.org>, peff@peff.net,
        gitster@pobox.com, sbeller@google.com, Johannes.Schindelin@gmx.de,
        jnareb@gmail.com, mlbright@gmail.com, jacob.keller@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <10020380-76ED-4371-A0BA-59D07AF33CE0@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-11-larsxschneider@gmail.com> <20160910062919.GB11001@tb-raspi>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 10 Sep 2016, at 08:29, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Thu, Sep 08, 2016 at 08:21:32PM +0200, larsxschneider@gmail.com =
wrote:
> []
>> +packet:          git> git-filter-client
>> +packet:          git> version=3D2
>> +packet:          git> version=3D42
>> +packet:          git> 0000
>> +packet:          git< git-filter-server
>> +packet:          git< version=3D2
>> +packet:          git> clean=3Dtrue
>> +packet:          git> smudge=3Dtrue
>> +packet:          git> not-yet-invented=3Dtrue
>> +packet:          git> 0000
>> +packet:          git< clean=3Dtrue
>> +packet:          git< smudge=3Dtrue
>> +packet:          git< 0000
>=20
> It's probalby only me who has difficulties to distinguish
> '>' from '<'.

I see what you mean. However, this format is used with =
"GIT_TRACE_PACKET"
as well and therefore I would prefer to keep it.


> packet:          git> git-filter-client
> packet:          git> version=3D2
> packet:          git> version=3D42
> packet:          git> 0000
> packet:       filter> git-filter-server
> packet:       filter> version=3D2
>=20
> (Otherwise the dialoge description is nice)

Thanks!


>> +------------------------
>> +Supported filter capabilities in version 2 are "clean" and
>> +"smudge".
>> +
>> +Afterwards Git sends a list of "key=3Dvalue" pairs terminated with
>> +a flush packet. The list will contain at least the filter command
>> +(based on the supported capabilities) and the pathname of the file
>> +to filter relative to the repository root. Right after these packets
>> +Git sends the content split in zero or more pkt-line packets and a
>> +flush packet to terminate content.
>> +------------------------
>> +packet:          git> command=3Dsmudge\n
>> +packet:          git> pathname=3Dpath/testfile.dat\n
>=20
> How do we send pathnames the have '\n' ?
> Not really recommended, but allowed.
> And here I am a little bit lost, is each of the lines packed into
> a pkt-line ?
> command=3Dsmudge is packet as pkt-line and pathname=3D is packed into
> another one ? (The we don't need the '\n' at all)

Every line is a dedicated packet. That's why '\n' in a path name would
not be a problem as the receiver is expected to read the entire packet
when parsing the value (and the receiver knows the packet length, too).

The '\n' at the end is required by the pkt-line format:
"A non-binary line SHOULD BE terminated by an LF..."
(see protocol-common.txt)


> Or go both lines into one pkt-line (thats what I think), then
> we don't need the '\n' afther the pathname.

No (see above).


> And in this case the pathname is always the last element, and a '\n'
> may occur in the pathname, since we know the length of the packet
> we know how long the pathname must be.
>=20
>=20
> [...]
>>=20
>> +In case the filter cannot or does not want to process the content,
>=20
> Does not want ?=20
> I can see something like "I read through the file, there is nothing
> to do. So Git, I don't send anything back, you know where the file is.

That's right. Isn't that covered with "does not want"?


>> +it is expected to respond with an "error" status. Depending on the
>> +`filter.<driver>.required` flag Git will interpret that as error
>> +but it will not stop or restart the filter process.
>> +------------------------
>> +packet:          git< status=3Derror\n
>> +packet:          git< 0000
>> +------------------------
>> +
>> +If the filter experiences an error during processing, then it can
>> +send the status "error" after the content was (partially or
>> +completely) sent. Depending on the `filter.<driver>.required` flag
>> +Git will interpret that as error but it will not stop or restart the
>> +filter process.
>> +------------------------
>> +packet:          git< status=3Dsuccess\n
>> +packet:          git< 0000
>> +packet:          git< HALF_WRITTEN_ERRONEOUS_CONTENT
>> +packet:          git< 0000
>> +packet:          git< status=3Derror\n
>> +packet:          git< 0000
>> +------------------------
>> +
>> +If the filter dies during the communication or does not adhere to
>> +the protocol then Git will stop the filter process and restart it
>=20
> My personal comment:
> When a filter is mis-behaving, Git should say so loud and clear, and
> die().=20
> The filter process can be left running, so that it can be debugged.

In the current implementation Git would die already if the filter is=20
"required". In this particular case we *could* die, too. However,=20
I would prefer to keep it as is because I think the users of a=20
"non-required" filter do not expect Git to die if there is *any*=20
problem with the filter.


> Here I stopped the review for a moment,=20
> I still think that Git shouldn't kill anything, because we loose
> the ability to debug these processes.

Based on my experience debugging the filter in this state is hard
anyways. I think a user would rather try to reproduce the problem
and run Git with the "GIT_TRACE_PACKET" flag enabled for debugging.


Thanks,
Lars=
