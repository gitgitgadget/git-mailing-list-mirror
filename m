From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Add fetch.recurseSubmoduleParallelism config option
Date: Fri, 16 Oct 2015 10:04:27 -0700
Message-ID: <CAGZ79kZDMawq6f3Jet0o-93-vSamy3skji63brdT3puzaLty5Q@mail.gmail.com>
References: <1444690350-6486-1-git-send-email-sbeller@google.com>
	<xmqqeggzbrx5.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuZZivs8czV2P6uHWaU6ay1hG21k-_G9tgN5KbV6jW8w@mail.gmail.com>
	<xmqqa8rnbq9k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Jens Lehmann <jens.lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 16 19:04:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zn8Qj-0008JP-Ms
	for gcvg-git-2@plane.gmane.org; Fri, 16 Oct 2015 19:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355AbbJPRE3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2015 13:04:29 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:33989 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbbJPRE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2015 13:04:28 -0400
Received: by ykfy204 with SMTP id y204so90767902ykf.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2015 10:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3fEYecjDkznjVs5KMI8m4pOA1o0VcK0Bbs2EkzvVUJg=;
        b=nwf+Ivglp+U1UzvCR4rOiizA64KHebVsJmAZgGoGJToqhsqncTrciOxTYvjI5xMRaG
         x+YL0j4f7mf43f1IHgmMRGKSO7nWOTiOWdbEx9v00mlpeDLpcHjRkiR7wJzZ21EFN3Gi
         jUPrkIUI9VB3GRgDW89PjunIdFLX5wZ8FI3L/aX0j8BPBf7uv5WezZ7HqOGtCf7MPESh
         YbGA0r8GSH3pp0TjIiUyiOJjrRmJQPnPJ4BndQNOe2aiSUVDJ7q7HhMHNdBX0Gzas3ho
         owGzlOc5xid5QFHLYYg3efiK02yvfwGIYo0/aH/4RqAgq2ORc/ILNfQPUd7K8J1h1X9I
         J6yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3fEYecjDkznjVs5KMI8m4pOA1o0VcK0Bbs2EkzvVUJg=;
        b=dUqFSwac9FnU7RBPyet69ZrvkLTKws2G1lhudONGrfIFbxD4x5q/s+iyV6wrzgtgGn
         SZax1KXs5xYyycNS1pQrN9lcazpDGuh0p0Wrmxpv/RElDrqTdgqCpf8/T8hpiNjNF2tt
         OL6MDRehUa05cpWzAp5UuOLKqd+fQA40kbWDjj3rh6b4WNgBmQ3YzUjmuhl2V6M7Dz8o
         HtTofzG87sVdTmNmBqpuCpwilxXwWKrOdETjEIyOTnEyGzS1RotktomBvXCa/vpNrhBJ
         UlMyzLob6SFNM6kqPHYkuzkACLZVU2Q1RK6m2Oo2JeTNwdcsTdVlr18NA7woMqkZvivm
         ulrA==
X-Gm-Message-State: ALoCoQlxi+3KL9Y/iqZ0UqjvbgZdUaqmbxxhPE44hmngBhqpdglYNwqK+jZIkw7ZqRAphZ/DZubj
X-Received: by 10.129.91.68 with SMTP id p65mr10860506ywb.252.1445015067588;
 Fri, 16 Oct 2015 10:04:27 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 16 Oct 2015 10:04:27 -0700 (PDT)
In-Reply-To: <xmqqa8rnbq9k.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279753>

On Mon, Oct 12, 2015 at 4:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> There is core.preloadIndex to enable parallel index preload, but
>> that is boolean and not giving fine control to the user. We want to give
>> fine control to the user here I'd assume.
>
> I'd approach this as "fetching multiple submodules at a time", if I
> were deciding its name.
>

so maybe
    fetch.recurseSubmoduleJobs
    fetch.submoduleJobs
    fetch.jobs
    fetch.connectionsToUse

Eventually we want to also be parallel in git fetch --all, when using
the latter two
we could reuse these then too, no need to support different options for
fetch --all and fetch --recurseSubmodules.


> So if you want
>
>     [submodule]
>         fetchParallel = 16
>         updateParallel = 4

So you would have different settings here for only slightly different things?
So the series I sent out yesterday evening, would make use of updateParallel
for parallel cloning then instead?
