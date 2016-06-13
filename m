From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/8] Add initial experimental external ODB support
Date: Mon, 13 Jun 2016 17:10:37 +0700
Message-ID: <CACsJy8ARuqKX1z4zze6Xj47X14tJ1eApCWivDwwuQh2gqRBYMw@mail.gmail.com>
References: <20160613085546.11784-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 12:11:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCOpt-0001qY-B2
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 12:11:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbcFMKLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 06:11:09 -0400
Received: from mail-it0-f52.google.com ([209.85.214.52]:37458 "EHLO
	mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964862AbcFMKLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 06:11:07 -0400
Received: by mail-it0-f52.google.com with SMTP id e5so39436913ith.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uXa3TpSVw4nui9PW+QM6wDTnUGs5/C69rjoIhh3cWLw=;
        b=0zYPn7lEip/TCnfM1sAxPIdN8XLnZzVTV5yX2eBExNwSTxOcbaFOyl7U/iNRgI2gOW
         M/UBaaFNs1dCDDo9Pq2Y7JBKvwOv/UgvJeRTVRyT8uzaAqX4CQ3jm6M/t9nvpK3lSQPA
         b3T0n3jsX58cPeGsE9jzK3oqM9yfZqgkVlHwrLKgAj0E+rzEstpWXmHlxzToNpX7+h0J
         gzkfb6v926dYiUH09od2sn+zuHPkAffYjIMosWTTQX67lTo4N64Vmnj/3U5hecQC2yKp
         DgfNPzeAaxZN86TbSc+7PVkFvLJiCjtyrGOC/Tdb4LLZlWY+ygYDrzwSo12Ggokyw4i2
         y05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uXa3TpSVw4nui9PW+QM6wDTnUGs5/C69rjoIhh3cWLw=;
        b=fqekA2VNdXmdTdKZXnzFIHUC+LNqiZa8jeRF7E7nC7G2aqzS1z/mt8Q9AICb8zM/de
         09lz+wH6lSQAKo0EqxRVu5Y8exXqrI3DdKqNcvghNNLHThw0M/ijVTwaJhRUvBeuA8nq
         d6aerqsFO7ohwZ6ToqtGJDSPMQcQhgEvU63A3h1v75DYG44zn3MImn7jqO+TC1s70xBx
         j03R8Xwedr7DQ+e8XuGrlUOyROfaMbvrBmRQcsHchdE5uloXr1vlIxw69h5rt+EDG5y7
         NQa+Ntvilq7BbwUaKTw/jR42BpUybjCzyiZdjTt/cP5R49DvcdfuYJZvtZ8nIaewpm8n
         fXHA==
X-Gm-Message-State: ALyK8tIi+CAfoD/1f2UkigXiMaut4AKo+OBHXT+v1I9dvh8zvAKVcPIFjsxRIZxR3HyJRSZCYlrHCX+t8smKPw==
X-Received: by 10.36.130.130 with SMTP id t124mr16594115itd.42.1465812666513;
 Mon, 13 Jun 2016 03:11:06 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 13 Jun 2016 03:10:37 -0700 (PDT)
In-Reply-To: <20160613085546.11784-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297177>

On Mon, Jun 13, 2016 at 3:55 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Future work
> ~~~~~~~~~~~
>
> From the discussions it appear that using the bundle v3 mechanism to
> tranfer external ODB data could work, but only if the server has access
> to its own external ODB.
>
> Another possible mechanism to transfer external ODB data would be some
> kind of replace refs. This would be slower but the mechanism for the
> transfer already fully exists.
>
> So I think I am going to experiment with some kind of replace refs.

Or we can go "fault-in" all the way.

1) Extend rev-list to support large blob exclusion, e.g. blobs whose
size above a certain limit are excluded, or blobs in certain paths are
excluded (maybe except those at the tip)

2) Add a new command, similar to "shallow", in the git protocol for
the client to tell the server that it does not want the server to send
certain large blobs (and the server probably should acknowledge with
"ok you can get them from this url...")

3) upload-pack passes the relevant rev-list blob filtering arguments
to pack-objects, no big blobs are transferred

4) External odb setting must be done (temporarily) before index-pack
is run (as part of the clone/fetch process). index-pack will notice
that certain blobs are missing from the received pack, but it will
also notice that it already has them via standard has_sha1_file() (we
just need to make sure it does not read blob content back, i think
we're ok here). I'm assuming here that EODB in fact contains _all_
blobs, so no extra setup is required at the server side.

5) If index-pack says "ok" then you can make this new external odb
permanent, else remove it.

Subsequent fetches need to send the same "do not include these blobs"
instructions, of course. Not sure how well it interacts with
pack-bitmap, but I guess when you use this, you probably already use
shallow clone (which disables pack bitmap).

> One interesting thing also would be to use the streaming api when
> reading from or writing to the external ODB.

If EODB is about large blobs only, you probably want to stream them
directly to a pack as you get them and not keep in loose object form.
Infrastructure is already in place (I think it's used by git-add), but
hooking it at sha1_file.c layer might be tricky. This is just cherry
on top, not strictly needed of course.
-- 
Duy
