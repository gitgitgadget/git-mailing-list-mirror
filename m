Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07884203C1
	for <e@80x24.org>; Wed, 16 Nov 2016 07:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752835AbcKPH7I (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 02:59:08 -0500
Received: from mail-yb0-f178.google.com ([209.85.213.178]:35976 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbcKPH7G (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 02:59:06 -0500
Received: by mail-yb0-f178.google.com with SMTP id v78so42054408ybe.3
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 23:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=t3GBdCZcIabZdl9XYV+fY2zBSKEI5szXciuytxEo1Es=;
        b=dAsiQTlh36hOni0S9TnHY1lgm0L599oPONuEK9vjzEv2F3LqE9tBZ7GvXpDvOfcN2U
         bhV/7sYjhzB2hpvuLL3tGhKC1af/SUharychXwpwKhBp9YoHMT+DF7zKhuJtPj9BInxp
         pmtbCrVMGH4W/A62wzK/vMAUsRVnyXjttASbFxruSxyOOzCizmxK84mwpYMb3byAeK7z
         rcia/ljUqgCAZaweh6qFaPFlPa1YoddMjs+rsbOmNdVCtq83Gl/4P4Ulf0SEuju87ZgC
         mUBvexecq1RLnWjyZf3EwrHYvjzO6BFBx73DvI4LBRNlRm+pRF9dJxHOoflSsFEXZwNx
         WMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=t3GBdCZcIabZdl9XYV+fY2zBSKEI5szXciuytxEo1Es=;
        b=mfK3HrWN/RFHZ7ZNv3J+LXg03XptfE3yTwdl1HAusPKHNkhDyu+LO5Xw4jVJx555/+
         3EvWbQjLyOhAv5se2nziQdzHFyQtLLuKyrg0lIX+TQ5H4O0HLGPQt50RwdyBRUHrmaoJ
         BckKVKTryruyQBVGbOfbrnqOg3NOnFL5zKrSNNJQShR3aPz8/1O/rvu7mQSXjW+4p4dl
         xHXtcBaTaWodTm/FqPtXisS3dJ6tieQP1i2FE31OC7Es0OHUbxjC5IthuL9WmivtAV8s
         T0zNRHkQcgVBX4u/eVLByJd8VmgeAmG6WEI/VHQ2X7NwzwHbn9d5UZL9fLn4uJDcoOve
         GCPA==
X-Gm-Message-State: ABUngvcmJNBLz/LECklCkT2Rqqxb/pQV/mMYFLTJT7ECil4ULFVG+ThwHUVrlBojJ2vfjq7Dr+PMmg7G/bVePg==
X-Received: by 10.37.172.65 with SMTP id r1mr826073ybd.132.1479283145605; Tue,
 15 Nov 2016 23:59:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 15 Nov 2016 23:58:35 -0800 (PST)
In-Reply-To: <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
 <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
 <xmqq60nqzuye.fsf@gitster.mtv.corp.google.com> <CAOLa=ZSFuq2+6xsrJ=CcXuOVbTnbDirbRtu7Fonfk+9EdRpbxg@mail.gmail.com>
 <xmqqy40lx2k8.fsf@gitster.mtv.corp.google.com> <CAOLa=ZQepW9GiUrKEWXojpy10B86K-jb84G_dJeL=mqtjZ4AWg@mail.gmail.com>
 <CA+P7+xo6OqcpLZ7v_m1EPm85eK2xCPD_LCw1Ly2RSPeSC0Ei7g@mail.gmail.com> <xmqq4m38vdw4.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 16 Nov 2016 13:28:35 +0530
Message-ID: <CAOLa=ZSaTdACC60g6D6k5frjKkChbkBL8+kLJjNgoutLSe8mOQ@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 15, 2016 at 11:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> dirname makes sense. What about implementing a reverse variant of
>> strip, which you could perform stripping of right-most components and
>> instead of stripping by a number, strip "to" a number, ie: keep the
>> left N most components, and then you could use something like
>> ...
>> I think that would be more general purpose than basename, and less confusing?
>
> I think you are going in the right direction.  I had a similar
> thought but built around a different axis.  I.e. if strip=1 strips
> one from the left, perhaps we want to have rstrip=1 that strips one
> from the right, and also strip=-1 to mean strip everything except
> one from the left and so on?.  I think this and your keep (and
> perhaps you'll have rkeep for completeness) have the same expressive
> power.  I do not offhand have a preference one over the other.
>

If we do implement strip with negative numbers, it definitely would be
neat, but to get
the desired feature which I've mentioned below, we'd need to call
strip twice, i.e
to get remotes from /refs/foo/abc/xyz we'd need to do
strip=1,strip=-1, which could be
done but would need a lot of tweaking, since we have the same
subatom/option having
multiple values.

On the other hand it would be easier maybe to just introduce rstrip,
where we strip from
right and ensure that strip and rstrip can be used together.

On Wed, Nov 16, 2016 at 2:49 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On November 15, 2016 9:42:03 AM PST, Junio C Hamano <gitster@pobox.com> wrote:
>>Somehow it sounds a bit strange to me to treat 'remotes' as the same
>>class of token as 'heads' and 'tags' (I'd expect 'heads' and
>>'remotes/origin' would be at the same level in end-user's mind), but
>>that is probably an unrelated tangent.  The reason this series wants
>>to introduce :base must be to emulate an existing feature, so that
>>existing feature is a concrete counter-example that argues against
>>my "it sounds a bit strange" reaction.
>
> It may be a bit strange indeed. What is the requirement for this?
>
> I think implementing a strip and rstrip ( if necessary ) with negative numbers would be most ideal.

The necessity is that we need to do different formatting as per the
ref type in branch -l. If you see the
last but one patch, we do

strbuf_addf(&fmt,
"%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)",
local.buf, remote.buf);

where its using ':base' to check for the ref type and do conditional
printing along with the %(if)...%(end) atoms.

-- 
Regards,
Karthik Nayak
