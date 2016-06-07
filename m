From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 4/4] bundle v3: the beginning
Date: Tue, 7 Jun 2016 15:19:46 +0200
Message-ID: <CAP8UFD3mGKTONzh1fxCJAJBrmc=OcCHeRqBQi-xTzHvcnAJ_sw@mail.gmail.com>
References: <xmqqfuw84uhb.fsf@gitster.mtv.corp.google.com> <1456950761-19759-1-git-send-email-gitster@pobox.com>
 <1456950761-19759-5-git-send-email-gitster@pobox.com> <CAP8UFD1xqRMFE2Wzntu=XevCyj+acGLEO-cTq1fqn+NMe3x0vg@mail.gmail.com>
 <20160531223118.GD3824@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:19:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGvC-0007eT-Ll
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 15:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbcFGNTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 09:19:50 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:35146 "EHLO
	mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbcFGNTt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 09:19:49 -0400
Received: by mail-wm0-f45.google.com with SMTP id v199so19258298wmv.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2016 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0h/Qx+RDWxdpmzlFmbhAeufq3ncDBON8Q2pUQ38fqtc=;
        b=tmbfRWdRgtjSLt+3EpbvrreWLM2Wa8DSzwSWeNxrt3uNIuhGOgIUWwTf+QNzzYE3PM
         lUIWnpCCIBXOkT7t1FQ3Koc787lcPNDFpQpeI5SdOs+wjAJWK0brK943LjRtB5OQN9QA
         gn9w0VADgyicxNikPbv4+gVGKpSpn0FaAV6lxRAvdsKR2kKuCUGUQuLU60nooSa49rL8
         c4icqtJeD06k6AKi0xgPqj35AzATqLDFC3QGssiln5nrKcLbrrExOQZkcMv1NJn6NPhv
         KDE2vk6MAlU0bG84a3WAHCkBENnuybSiTxoWuDc1LgZBcUxsscJygvIPgCEVUsj0a//R
         uhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0h/Qx+RDWxdpmzlFmbhAeufq3ncDBON8Q2pUQ38fqtc=;
        b=JV5FKDkvXai/2I459mwxqC5tFMZdQ1zdtIy/+1Al+8X8koH3HLnZYCn6fqYyK4b5nb
         uPu1KNokidDGCb7j1FD/PMqQ8gnNBIKydI5qpLvMZCRPq1eJZJhMuQsJNGfp1nzfzkCE
         D3kQEL75JioB5ezUfYJeA4Oz992oUxk7AY5SpqijaH5UDkmUuoSvDpMi57kGHHPPF8lh
         ZtpspgHBnxbyNFMqr/clYOBL5iB62Irfby3ZH6XZmciUYQ5ofwOO/z2lDwG5esvtQwZO
         OgEGJXqjzEgoJmx8ghzSHY7Xv35VRU3H9yMY94IJsV/tc+nA6Ny9GQ44S/RlotOmVnbU
         yrfg==
X-Gm-Message-State: ALyK8tLrCZTg4zSAKJvyDGPFITADBGhJKw/MVmF4CuRH/w08GHDOhZAAVkLFbIvKXYwzCObuA5lNHTphoigc3Q==
X-Received: by 10.28.183.8 with SMTP id h8mr2595547wmf.79.1465305587707; Tue,
 07 Jun 2016 06:19:47 -0700 (PDT)
Received: by 10.194.148.146 with HTTP; Tue, 7 Jun 2016 06:19:46 -0700 (PDT)
In-Reply-To: <20160531223118.GD3824@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296678>

On Wed, Jun 1, 2016 at 12:31 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 20, 2016 at 02:39:06PM +0200, Christian Couder wrote:
>
>> I wonder if this mechanism could also be used or extended to clone and
>> fetch an alternate object database.
>>
>> In [1], [2] and [3], and this was also discussed during the
>> Contributor Summit last month, Peff says that he started working on
>> alternate object database support a long time ago, and that the hard
>> part is a protocol extension to tell remotes that you can access some
>> objects in a different way.
>>
>> If a Git client would download a "$name.bndl" v3 bundle file that
>> would have a "data: $URL/alt-odb-$name.odb" extended header, the Git
>> client would just need to download "$URL/alt-odb-$name.odb" and use
>> the alternate object database support on this file.
>>
>> This way it would know all it has to know to access the objects in the
>> alternate database. The alternate object database may not contain the
>> real objects, if they are too big for example, but just files that
>> describe how to get the real objects.
>
> I'm not sure about this strategy.

I am also not sure that this is the best strategy, but I think it's
worth discussing.

> I see two complications:
>
>   1. I don't think bundles need to be a part of this "external odb"
>      strategy at all. If I understand correctly, I think you want to use
>      it as a place to stuff metadata that the server tells the client,
>      like "by the way, go here if you want another way to access some
>      objects".

Yeah, basically I think it might be possible to use the bundle
mechanism to transfer what an external ODB on the client would need to
be initialized or updated.

>      But there are lots of cases where the server might want to tell
>      the client that don't involve bundles at all.

The idea is also that anytime the server needs to send external ODB
data to the client, it would ask its own external ODB to prepare a
kind of bundle with that data and use the bundle v3 mechanism to send
it.
That may need the bundle v3 mechanism to be extended, but I don't see
in which cases it would not work.

>   2. A server pointing the client to another object store is actually
>      the least interesting bit of the protocol.
>
>      The more interesting cases (to me) are:
>
>        a. The receiving side of a connection (e.g., a fetch client)
>           somehow has out-of-band access to some objects. How does it
>           tell the other side "do not bother sending me these objects; I
>           can get them in another way"?

I don't see a difference with regular objects that the fetch client
already has. If it already has some regular objects, a way to tell the
server "don't bother sending me these objects" is useful already and
it should be possible to use it to tell the server that there is no
need to send some objects stored in the external ODB too.

Also something like this is needed for shallow clones and narrow clones anyway.

>        b. The receiving side of a connection has out-of-band access to
>           some objects. Some of these will be expensive to get (e.g.,
>           requiring a large download), and some may be fast (e.g.,
>           they've already been fetched to a local cache). How do we tell
>           the sending side not to assume we have cheap access to these
>           objects (e.g., for use as a delta base)?

I don't think we need to tell the sending side we have cheap access or
not to some objects.
If the objects are managed by the external ODB, it's the external ODB
on the server and on the client that will manage these objects. They
should not be used as delta bases.
Perhaps there is no mechanism to say that some objects (basically all
external ODB managed objects) should not be used as delta bases, but
that could be added.

Thanks,
Christian.
