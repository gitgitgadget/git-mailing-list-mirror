From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 03/16] refs: add methods for the ref iterators
Date: Mon, 4 Jan 2016 11:12:19 -0800
Message-ID: <CAL=YDW=3JE==2s7Y3-fVRnTgaAzT674CAnypuXOKynpfD0q=Bg@mail.gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	<1449102921-7707-4-git-send-email-dturner@twopensource.com>
	<20160103000623.GB14424@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 20:12:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGAYL-0004bl-3X
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jan 2016 20:12:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752064AbcADTMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 14:12:22 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33543 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbcADTMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 14:12:20 -0500
Received: by mail-wm0-f52.google.com with SMTP id f206so2484965wmf.0
        for <git@vger.kernel.org>; Mon, 04 Jan 2016 11:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=o3OASmWx6IY1dAoMrqxPN/VmH3BiRQTF1ibuJ1/gn80=;
        b=XwDPAtC63LGKO+8CTzVYfzfBNtUwEKtBiDK2JYJyBUJvwHYMJAI8oiBJ/zuCHifQP3
         uGrkckDy4r4WkcUhkrCxpaWP5tZIW2x4gAqKVRWiHMse8i8eGg1KMVaKc7AZYS8lh00p
         CQ89V82pXMx+V76f0/itpXcNv35tV3BW5UvgvhMgR7U5fr+HzCBS9KZKIVo4Gkk+Rhdc
         S/bLjv0jwdljCzHgFfW0AqhMjJD2tq8CvswYkKoNUWXoSWaTVEDOxSOI/oMm6gDC/vZs
         PubsGMxZuI+1MvsLCWTSwjMGVbBn1OKOk/tQ/eZxIJ7Dltbo2wE85hg3r1EkMh5q8BOY
         rO4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=o3OASmWx6IY1dAoMrqxPN/VmH3BiRQTF1ibuJ1/gn80=;
        b=cxC2ZcgIYwf8ZoyOfpNPP6wGOXsKskl7w1NlUqvUS0S9CXV7DTwV8laa+o4Fw3/Fh+
         gIv/q2Ys9YQkGmbomasCBYQzE2syzzHD7ttBpZ+oll9f0bNTn54k3kLVrA98n3grvXR9
         RrYeJ96ndcaC4nPz36sjlS+yzZMZivI+0vM/mRFvIpB3bbWw9lsFDOB/bjKtU6C1mXyG
         ar9kaFYgryQINzoCp1MBzMDYcD3d2aC9RWFdbGjdpnDZC947v2W4SEOtk5GVeqAoc0WT
         BA70IcGUAeXl8VtC+uVrHYqMTxe7eULsm7msUGlqr3gW8Fi3hYpoDR7t/+yaEg4BDJ8c
         MEIQ==
X-Gm-Message-State: ALoCoQnPpWUlQgFWrfXHs6DLRVvlxrT88+nKpm8vTS4hkkOlBCZTRJaIp2N08EIiEzNSmXeaydzHw8zkuOw+csRomZ9IyIUYMlIhGfTT01rH2WuLViFkl6E=
X-Received: by 10.194.103.69 with SMTP id fu5mr110038359wjb.2.1451934739162;
 Mon, 04 Jan 2016 11:12:19 -0800 (PST)
Received: by 10.28.216.18 with HTTP; Mon, 4 Jan 2016 11:12:19 -0800 (PST)
In-Reply-To: <20160103000623.GB14424@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283316>

On Sat, Jan 2, 2016 at 4:06 PM, David Aguilar <davvid@gmail.com> wrote:
> Apologies for the late review, and this review should probably
> go on patch 01 or 02 but I don't have it in my mbox atm...
>
> On Wed, Dec 02, 2015 at 07:35:08PM -0500, David Turner wrote:
>> From: Ronnie Sahlberg <sahlberg@google.com>
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: David Turner <dturner@twopensource.com>
>> ---
>>  refs.c               | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
>>  refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
>>  3 files changed, 112 insertions(+), 12 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 9562325..b9b0244 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -1150,3 +1150,57 @@ int resolve_gitlink_ref(const char *path, const char *refname,
>>  {
>>       return the_refs_backend->resolve_gitlink_ref(path, refname, sha1);
>>  }
>> +
>> +int head_ref(each_ref_fn fn, void *cb_data)
>> +{
>> +     return the_refs_backend->head_ref(fn, cb_data);
>> +}
>
> My only comment is that it seems like having a single static global
> the_refs_backend seems like it should be avoided.
>
> It seems like the intention was to keep the existing interface
> as-is, which explains why this is using globals, but it seems
> like the refs backend should be part of some "application
> context" struct on the stack or allocated during main().  It can
> then be passed around in the API so that we do not need to have
> a global.

Not commenting on whether this is the right direction or not. A global
variable holding a methods table might not be most aesthetic design,
but there are practicalities.

However, that kind of change would change the function signatures for
all public refs functions and probably most private refs functions as
well and will likely have massive conflicts with almost any other
patch that touches the refs code.

If doing this API change is desired it is probably best to do that as
a separate patch later that ONLY does this signature change and
nothing else to make review easier and to possibly make merge conflict
changes easier to manage.



>
> That way the code will not be tied to a specific single
> the_refs_backend and could in theory have multiple backends
> working at the same time.  If submodule were ever rewritten in C
> then this could potentially be a useful feature.
>
> That said, the refs backend is not the only global static data
> in git that would need to be factored out, but it wouldn't hurt
>ice,  to make this part a little more tidy.
>
> Thoughts?
> --
> David
