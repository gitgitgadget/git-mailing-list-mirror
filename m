Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49A831FA21
	for <e@80x24.org>; Sun,  8 Oct 2017 12:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751867AbdJHMX1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 08:23:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:43238 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751747AbdJHMX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 08:23:26 -0400
Received: by mail-pf0-f181.google.com with SMTP id d2so8299210pfh.0
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FsS3D8jIauVX4Vp3yZOpoDp0ts7YPxU/Y05vOoKSNs4=;
        b=ElEZQkvVTUm5vJuB8CgRgGyuXijhIIkhbgchjZUDa+i0aL00VVRIwIdrEai8TVzGKD
         0vyBvatm9xJe0wbHMyZjb41MXYprjcbEhPpdPK/vvrzBIodw8NK4TRTOr26LDgjfXq7t
         06BU0SEaFPkvdhf1pKb457UYv27XFzL/tq443rybZW89CNjqDgXJuC5T4SzlkKEM111v
         kqgHZfiiZcrdmWyFoHmQKiPzlUhJSdNEnJq+4qqUfB4sYXgiMdAC4/6xQwfunPqDPOUT
         OJjvtP/1qpXhGd6eQWv9YrIrg7k0vaF1fIgK71NtYEhdXxPAb/LezVw1kU6HLlVpU/as
         PKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FsS3D8jIauVX4Vp3yZOpoDp0ts7YPxU/Y05vOoKSNs4=;
        b=Rt2xlCTg0qdtHnHfZCQaIG3HrB9zS3OXwLnSEMF0pGH+YmVUBDOY6IaTECcjBE03Wh
         TmO/ytDfne261NFE2Utox6hEgDlLQldJTlepaPiw1PEf433WFS1Kqw/5JL1nlnMUNCP+
         gVQ3B3Vn/QXuGr6HMFKRoRvZ/++McAKRrmd8qPUuwP+BR+7G2ynEPXGHbGGW/vhDRj/c
         qaF7JKiwot3US/qd3uB6JPKjHTKoA9NcF/idUj45t/C7WobEhNxcUG/nsK7CCeel2RZI
         03aioolSjiBny/p9awfuALcsNfZ3PLhApaaKbR0TLa1X9woJ5yMsiwIVtudmu2kisISG
         FecA==
X-Gm-Message-State: AMCzsaWCG+8clZKxOxxW78KRYH5wIGczcj7JYbiy0C5NftmRYCU4KmMc
        os7HIK4kmcvEqmwM6bPfjmqqdzSZvsOAlRhYSCw=
X-Google-Smtp-Source: AOwi7QCE88diL4W5ue/626ty6gs3lOlftG40wQBI/liTuhi8+00WwGt+eZ1bjXC+vqrBuQx4+bnkn1yEehWIvDWXd0o=
X-Received: by 10.159.206.134 with SMTP id bg6mr6622004plb.273.1507465405741;
 Sun, 08 Oct 2017 05:23:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 8 Oct 2017 05:23:24 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
References: <alpine.LFD.2.21.1710071436140.14843@localhost.localdomain>
 <20171007190402.GH3382@zaya.teonanacatl.net> <alpine.LFD.2.21.1710071506210.15271@localhost.localdomain>
 <20171007192902.ma4s47hn6edwldx5@sigill.intra.peff.net> <alpine.LFD.2.21.1710071531090.15738@localhost.localdomain>
 <20171007193805.a2mwzkweonb6ymdk@sigill.intra.peff.net> <alpine.LFD.2.21.1710071541430.15964@localhost.localdomain>
 <1507412674.8322.4.camel@mad-scientist.net> <alpine.LFD.2.21.1710071749240.16818@localhost.localdomain>
 <xmqqy3oms22q.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.21.1710080736530.21897@localhost.localdomain>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 8 Oct 2017 14:23:24 +0200
Message-ID: <CAN0heSqvz1ak8BvM=i9FGPm=_4Fi7WLhZhPMN37GN-VngewkuA@mail.gmail.com>
Subject: Re: "git rm" seems to do recursive removal even without "-r"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Paul Smith <paul@mad-scientist.net>,
        Git Mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8 October 2017 at 13:56, Robert P. J. Day <rpjday@crashcourse.ca> wrote:
>   but as i asked in my earlier post, if i wanted to remove *all* files
> with names of "Makefile*", why can't i use:
>
>   $ git rm 'Makefile*'
>
> just as i used:
>
>   $ git rm '*.c'
>
> are those not both acceptable fileglobs? why does the former clearly
> only match the top-level Makefile, and refuse to cross directory
> boundaries?
>
>   $ git rm -n 'Makefile*'
>   rm 'Makefile'
>   $

Hmmm. The manpage says the following:

       git rm -f git-*.sh
           Because this example lets the shell expand the asterisk (i.e.
           you are listing the files explicitly), it does not remove
           subdir/git-foo.sh.

This implies that `git rm "git-*.sh"` should remove subdir/git-foo.sh.
But it doesn't, at least not in my testing. It seems that the globbing
only kicks in when the "*" comes first, as you've noted.
