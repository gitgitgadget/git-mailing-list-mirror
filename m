Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914FC1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752851AbeDXSvg (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:51:36 -0400
Received: from mout.gmx.net ([212.227.17.20]:60601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751995AbeDXSvf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:51:35 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MUUWN-1f1K8g1wQt-00RJef; Tue, 24
 Apr 2018 20:51:29 +0200
Date:   Tue, 24 Apr 2018 20:51:21 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     Stefan Beller <sbeller@google.com>
cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v4 04/11] replace: "libify" create_graft() and callees
In-Reply-To: <CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804242048360.64@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <cover.1524262793.git.johannes.schindelin@gmx.de> <cover.1524303776.git.johannes.schindelin@gmx.de> <f962f8043fb1125b47090a82c35e2d67d3d9d216.1524303776.git.johannes.schindelin@gmx.de>
 <CAGZ79ka=BLGCCTOw848m0SE9O+ZKhQfiW9RUz99W4=Gdg+7ofQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:2+o/2495sq1LayZ3d/5dQYmKkLS58crON9Dmn/rea/Ur1ouK/rd
 ToyMr8WgGfVW863DaxIJOXa0bFyi6GVoXvtvMuCFlp32xRVpSO2LaH6IAGm2GVrTf8VGuiU
 J9Ye7Nbltj/v+qcJoXVuD7gthqFacW+1OLM4oGyUteaw7Hh6dM0UaBaDUKy6XxeYyVBelz7
 oOWV/Pm/j3Y49xIgQ+tgw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RkZnuFsY95w=:3C/m25pRClLlHXJz3bHrMv
 D+HCPvC6szE/i/Ee3s8YUkZAVSUg9usNVzwHy6ycpxwj0+e5eN+Pai2wE5k7exN7XUdUBtdv+
 kIT1fQlGZuk26p01dkk/qV5H6YvdpFHSLKjGqF7jaQQ3JxSQbWlBSOpFdB7L5cGK6ONetgrZG
 j65fTYosGNunoAl6eAIM/w/CODhShGsxd6TG0hwtpCLeQeRtudlgMnTkUcme7plVz6YQuDD1i
 MWh0RTUtXSXqPkzb0TmZlNIvRmbtBBG/OTQ+XvXWUent0RryJ501KFESo1J8THeLM8vuxgQv+
 W27mwhe7jQBb5PMyx+SrM2ZJaEbdSOvX9zu/M8nYD0KSWACJgSYqCLYcEVSAgPGz3IIM0LYax
 KIA5fpv/Lflfo0jyvjqcLvPuJa5Co8AtWzjbN5MpcxJx12fX8lSjXNJFbvtboM9b9DpTDTPyg
 ZrL6EHUPcI1sV2+kufzOdOZEK7w2keko1RlAPIt3Ay2ick42lBb/spklZ31gHu28IOXcAEAD0
 2Busau6jOmpVmf6dmHnp+1RMeD0z1EmrLyz/KpIxZUzOz4ndG2cvrmuHtUlJwG80zn7PPCEuJ
 DFSiK9zK7AJ3LIAW5J4YiDCrTmwq5u0Nc6cGB20Aj7BvUi/9BJi/1gz8fDQy0W57bM178z6OX
 D3upj9877wroBHMnSWj74PjWsyLANc3j2U9FLjEb6BTKEqGB4OANUdjjMROu1utQZKyy/gU4u
 0Ilqk3NdImSGAKOBr2E6X4qtZmrtzwa9T9bkmEX7WmHPZfIeGReKkCIB2WP7Z/89srDreN2TO
 uS0OR5mKfZs2FUF0lMjGpWaHf+sJkhDgZoEYVKkKNqD7yUIfj8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 23 Apr 2018, Stefan Beller wrote:

> On Fri, Apr 20, 2018 at 3:21 PM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > @@ -250,27 +257,38 @@ static void import_object(struct object_id *oid, enum object_type type,
> > -               if (strbuf_read(&result, cmd.out, 41) < 0)
> > -                       die_errno("unable to read from mktree");
> > +               if (strbuf_read(&result, cmd.out, 41) < 0) {
> > +                       close(fd);
> > +                       close(cmd.out);
> > +                       return error_errno("unable to read from mktree");
> 
> So before the errno is coming directly from strbuf_read,
> which will set errno on error to the desired errno.
> (It will come from an underlying read())

Yes, you are right!

> However close() may fail and clobber errno,
> so I would think we'd need to
> 
>     if (strbuf_read(&result, cmd.out, 41) < 0) {
>       int err =  errno; /* close shall not clobber errno */
>       close(fd);
>       close(cmd.out);
>       errno = err;
>       return error_errno(...);
>     }

I went for the easier route: call error_errno() before close(fd), and then
return -1 after close(cmd.out). Since error_errno() always returns -1, the
result is pretty much the same (I do not think that we want the caller of
import_object() to rely on the errno).

> > -               if (fstat(fd, &st) < 0)
> > -                       die_errno("unable to fstat %s", filename);
> > +               if (fstat(fd, &st) < 0) {
> > +                       close(fd);
> > +                       return error_errno("unable to fstat %s", filename);
> > +               }
> 
> Same here?

Yep.

> An alternative would be to do
>     ret = error_errno(...)
>     close (..)
>     return ret;

I even saved one variable ;-)

> > @@ -288,19 +307,23 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
> >         struct strbuf ref = STRBUF_INIT;
> >
> >         if (get_oid(object_ref, &old_oid) < 0)
> > -               die("Not a valid object name: '%s'", object_ref);
> > +               return error("Not a valid object name: '%s'", object_ref);
> >
> >         type = oid_object_info(&old_oid, NULL);
> >         if (type < 0)
> > -               die("unable to get object type for %s", oid_to_hex(&old_oid));
> > +               return error("unable to get object type for %s",
> > +                            oid_to_hex(&old_oid));
> >
> > -       check_ref_valid(&old_oid, &prev, &ref, force);
> > +       if (check_ref_valid(&old_oid, &prev, &ref, force))
> > +               return -1;
> >         strbuf_release(&ref);
> >
> > -       export_object(&old_oid, type, raw, tmpfile);
> > +       if (export_object(&old_oid, type, raw, tmpfile))
> > +               return -1;
> >         if (launch_editor(tmpfile, NULL, NULL) < 0)
> > -               die("editing object file failed");
> > -       import_object(&new_oid, type, raw, tmpfile);
> > +               return error("editing object file failed");
> > +       if (import_object(&new_oid, type, raw, tmpfile))
> > +               return -1;
> >
> >         free(tmpfile);
> 
> Do we need to free tmpfile in previous returns?

Oy vey. How many more mistakes can I introduce in one commit...

> > @@ -394,24 +422,29 @@ static int create_graft(int argc, const char **argv, int force)
> >         unsigned long size;
> >
> >         if (get_oid(old_ref, &old_oid) < 0)
> > -               die(_("Not a valid object name: '%s'"), old_ref);
> > -       commit = lookup_commit_or_die(&old_oid, old_ref);
> > +               return error(_("Not a valid object name: '%s'"), old_ref);
> > +       commit = lookup_commit_reference(&old_oid);
> > +       if (!commit)
> > +               return error(_("could not parse %s"), old_ref);
> >
> >         buffer = get_commit_buffer(commit, &size);
> >         strbuf_add(&buf, buffer, size);
> >         unuse_commit_buffer(commit, buffer);
> >
> > -       replace_parents(&buf, argc - 1, &argv[1]);
> > +       if (replace_parents(&buf, argc - 1, &argv[1]) < 0)
> > +               return -1;
> >
> >         if (remove_signature(&buf)) {
> >                 warning(_("the original commit '%s' has a gpg signature."), old_ref);
> >                 warning(_("the signature will be removed in the replacement commit!"));
> >         }
> >
> > -       check_mergetags(commit, argc, argv);
> > +       if (check_mergetags(commit, argc, argv))
> > +               return -1;
> >
> >         if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
> > -               die(_("could not write replacement commit for: '%s'"), old_ref);
> > +               return error(_("could not write replacement commit for: '%s'"),
> > +                            old_ref);
> >
> >         strbuf_release(&buf);
> 
> Release &buf in the other return cases, too?

Absolutely.

Thank you for helping me improve these patches,
Dscho
