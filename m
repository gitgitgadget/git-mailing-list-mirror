Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DC71FAED
	for <e@80x24.org>; Thu, 26 Oct 2017 09:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751251AbdJZJH1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Oct 2017 05:07:27 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:47089 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdJZJHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Oct 2017 05:07:25 -0400
Received: by mail-wm0-f42.google.com with SMTP id m72so6534735wmc.1
        for <git@vger.kernel.org>; Thu, 26 Oct 2017 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k/R8IH375T6Q0lC566Vtd1YtDedVZyl5GxsYmM9lykw=;
        b=tsfcEpCwbfuu+mEle0NhacM/n20QAark0j78ArNHON4H5VbUtYNpvp9Q/6o6sdTqky
         El8qc14IFotAuw2qRd2LbWDHNGh5T7yhE5iN8sCvd01jU+qPJxm5yDCGfXgHP2PG8hBx
         t+0tZ8hgcckDKoH7NsuxaYwF6f1BnnP2tsuW1C1xIyY5r0zbnwXdO7kbeJFScgB/qDlL
         oUj5tw50gEfR+j5dJ0wObYx5mo/SnS8gWfTgsRU5oZsB7IZIbVBA3QgqnBHaggvUjWHP
         EjIhPG/EXZr9qINjYtXMjZULQb70bJYQNQ9E7bwLK3YP+oi0MMcuyYKZlGj+1snwNrIP
         /LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k/R8IH375T6Q0lC566Vtd1YtDedVZyl5GxsYmM9lykw=;
        b=Q+YIfGFjphfGOvJL9MEp2iQYxm3W7oBDBWFyBjNcl4BL9uZ20uZLPaq75c02fjH30l
         eCCVP4/DQ1LBlq4u7HI/dHDosMSD8ILBPp8sQ+BpFzAZNPfNRjCNdYu5BJi9/6Wm+Wq1
         xU9XkJWVcXlQOapQ0vTSEjuGrAlRgqJAsAcR2NzSAN893XAeba3L0So3u2bUqtvWYfHX
         S4GQIG4WAvLIzax/J/EttiTn8nDzbyoLbiELxJuLPeau7q1zKs39OkY4qMRRGPPE3Vig
         bov9wGnES1oyS+PanHZYlI9sA4ZJzBr7gkM/d3EfOexX8CMu21lsWH/MMRSmaSRIgvGs
         bQ1g==
X-Gm-Message-State: AMCzsaU8HQcvFLZYXH+1GyQe8bLZBAVPpF2QtQyWYN6vhYCXCnetLjGb
        Dw0qU2dQmOnFOiPrxf80D6sjgaErX1v/MD2Illw=
X-Google-Smtp-Source: ABhQp+QRZHDIPUK1uLZAEreQiN0iTUjamKOO0EfI9hONDP1WJhC+/Lxutc0zvAQpfvBs6lXBvxDt4/4eVRGe+kG1dbo=
X-Received: by 10.80.217.15 with SMTP id t15mr27664808edj.217.1509008843984;
 Thu, 26 Oct 2017 02:07:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.213.80 with HTTP; Thu, 26 Oct 2017 02:07:03 -0700 (PDT)
In-Reply-To: <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
References: <20171019123030.17338-1-chriscool@tuxfamily.org>
 <alpine.DEB.2.21.1.1710260008270.37495@virtualbox> <xmqq4lqmfoy7.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 26 Oct 2017 02:07:03 -0700
Message-ID: <CA+P7+xpcC7Daw5k3=XFyZRsqiBib6yY2YzLpjYfcS7yqfUzTpg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Create Git/Packet.pm
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 25, 2017 at 10:38 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Note that the correct blib path starts with `C:\BuildAgent\_work` and
>> the line
>>
>>       use lib (split(/:/, $ENV{GITPERLLIB}));
>>
>> splits off the drive letter from the rest of the path. Obviously, this
>> fails to Do The Right Thing, and simply points to Yet Another Portability
>> Problem with Git's reliance on Unix scripting.
>
> In our C code, we have "#define PATH_SEP ';'", and encourage our
> code to be careful and use it.  Is there something similar for Perl
> scripts, I wonder.
>
> I notice that t/{t0202,t9000,t9700}/test.pl share the same
> split(/:/, $ENV{GITPERLLIB}); forcing this specific variable to use
> the non-platform convention to accomodate the use of split(/:/)
> certainly is a workaround, but it does feel dirty.
>
> It is hard to imagine that we were the first people who wants to
> split the value of a variable into a list, where the value is a list
> of paths, concatenated into a single string with a delimiter that
> may be platform specific.  I wonder if we are going against a best
> practice established in the Perl world, simply because we don't know
> about it (i.e. basically, it would say "don't split at a colon
> because not all world is Unix; use $this_module instead", similar to
> "don't split at a slash, use File::Spec instead to extract path
> components").
>

I thought there was a way to do this in File::Spec, but that's only
for splitting regular paths, and not for splitting a list of paths
separated by ":" or ";"

We probably should find a better solution to allow this to work with
windows style paths...? I know that python provides os.pathsep, but I
haven't seen an equivalent for perl yet.

The Env[1] core modules suggests using $Config::Config{path_sep}[2]..
maybe we should be using this?

Thanks,
Jake

[1] https://perldoc.perl.org/Env.html
[2] https://perldoc.perl.org/Config.html
