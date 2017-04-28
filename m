Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,UNWANTED_LANGUAGE_BODY
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32CAE1FC3E
	for <e@80x24.org>; Fri, 28 Apr 2017 10:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424567AbdD1KCa (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 06:02:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:64209 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424557AbdD1KC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 06:02:28 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MPlY2-1d7sDZ0Vhi-00504O; Fri, 28
 Apr 2017 12:02:19 +0200
Date:   Fri, 28 Apr 2017 12:02:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Johannes Sixt <j6t@kdbg.org>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 06/26] get_mail_commit_oid(): avoid resource leak
In-Reply-To: <ac257961-3133-0de4-d918-cfb8da8fbf89@kdbg.org>
Message-ID: <alpine.DEB.2.20.1704281201570.3480@virtualbox>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <1a12ba40a2db3925534bd2192ed8e9ab9a87215e.1493237937.git.johannes.schindelin@gmx.de> <ac257961-3133-0de4-d918-cfb8da8fbf89@kdbg.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4nOk9s4QYuPlJ4tpVOMzP37+hDwODzQGOXePn8y0in0Mu31z5n3
 Ak76bns/gaHMRORuOkLAh8CQN55TUNb+Bk8HfMGd4nNzJC0zGAlJ4TR4nA1c/mqqSrI/3dk
 r6m8PgVuvE7dSdL4Z2mJKOW66O55u0LV34Gz0sUIM1efkF4aR05VrM3QsZguP+A/O2BenoL
 y0JdU+HMgv8qAD7gPcsNg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ulcYO1DWxwI=:peRHGueweofl9kbODLeTwx
 Px1Uf0PxgoT3iNuexzDBLfFmfvA7MrPdBT7xNifaK3YRVOIeMNmQX3lliCNOI/iUOWoPnSmrb
 mH/ierIKXsJTWZJPmbNpIzGT9RrLIBPrsboHi55u0QkpMWm204gBTP0bwuGZF10Du0L2SRKtN
 6EOYSC3oVUZr5Jfgiw2o/rOnMyW3kuxCCgZjVJuXheFKIjO+lYomrgOnRWrRdV7RtIqZ1+gvf
 nvCuw2hNSqNz1WuX1/Rj9V810mRkkRDX0jD9Mk+dn8FyIgtcOzsD/F5SFt1iXlKs+8vULvF+S
 Cr7FOTeu5BZnXO2DvoO0tyzLw1KVvEBYaIZw1NWQ0t2afSwgIvymzQbgOdsu5b7QUOsj5kMZt
 tlg9yHElbEKmhBkn5zRRmqHdg/NctHDGBNdkbKL0VEnMSxqLTLOQU4LvqPQCkz0XIPWeOdXeq
 hp8ycAuZsH6Ehxi+Y8VcaZ0oSPP7rCVT45aMcclxwtn5YKFk8ZbUJkc8ffxUSwbUvdBQeYWsK
 EpzyH1VsPEoAtLxchWTfqJFqZ2rmwgImImGlfWe2AsnHG7oDgEMSerC7fxS153bfCb1PjSIYI
 2S+uIxJhyQWH/EjiesQTwEL3Z21ojr8xz2L8yMnjb3ZdZmxPaOYroDhaTBWl1MR17wRKGcZ77
 FWvqcMHSwX7C+9MiYqqAbfK2cZT3hzzvoLU0HLJNP7hxMENLaGJZTPvVH82CNnYwAhWfMzjqN
 LuydgT6oFWHHtJcVmlZhEAdnHgHjMjgDY+2MbDsn71YTYivAcBseNrp+WrWWZIuHD+GKrclJG
 kT0eZ5u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Thu, 27 Apr 2017, Johannes Sixt wrote:

> Am 26.04.2017 um 22:19 schrieb Johannes Schindelin:
> >
> > diff --git a/builtin/am.c b/builtin/am.c
> > index 805f56cec2f..01b700e5e74 100644
> > --- a/builtin/am.c
> > +++ b/builtin/am.c
> > @@ -1359,15 +1359,16 @@ static int get_mail_commit_oid(struct object_id
> > *commit_id, const char *mail)
> >   struct strbuf sb = STRBUF_INIT;
> >   FILE *fp = xfopen(mail, "r");
> >   const char *x;
> > +	int ret = 0;
> >
> > 	if (strbuf_getline_lf(&sb, fp))
> > -		return -1;
> > +		ret = -1;
> >
> > -	if (!skip_prefix(sb.buf, "From ", &x))
> > -		return -1;
> > +	if (!ret && !skip_prefix(sb.buf, "From ", &x))
> > +		ret = -1;
> >
> > -	if (get_oid_hex(x, commit_id) < 0)
> > -		return -1;
> > +	if (!ret && get_oid_hex(x, commit_id) < 0)
> > +		ret = -1;
> >
> >   strbuf_release(&sb);
> >   fclose(fp);
> >
> 
> You forgot to 'return ret;', didn't you?

I sure did!

Thanks,
Dscho
