From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Resumable git clone?
Date: Wed, 2 Mar 2016 15:22:17 +0700
Message-ID: <CACsJy8CBBk4bgz6Gn0QvCwWtOsqcQZBYgOBQTd=4Y+2YKs44Qg@mail.gmail.com>
References: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
 <CAGZ79kYjuaOiTCC-NnZDQs=XGbgXWhJe7gk576jod4QnV57eEg@mail.gmail.com>
 <20160302023024.GG17997@ZenIV.linux.org.uk> <20160302081344.GB8024@x>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, sarah@thesharps.us
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Mar 02 09:22:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ab23Y-0001qn-LI
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 09:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbcCBIWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 03:22:49 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:32832 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167AbcCBIWs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 03:22:48 -0500
Received: by mail-lf0-f48.google.com with SMTP id v124so36826816lff.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 00:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BYwJF62MfFPS8oc1BGx0H93M3H8BBvu29vXLRwdYmGM=;
        b=Oz++DSuDZJqbM2j7F2+c9e0pjzZYOvnfKrmmMqQFebjA82pCnaO7M+ZvYahpWqlOmT
         vTkJeeeuPZJHQtEKELKYlMv0yKjn568IvKqtZ85wWFf7Uuo4Acz8R/BC+9NAngt4hac3
         EtzVQ7hDS3XdUrqWtJ8xUt99E9xyHOg9EpCwF0N3vcYj0lyfI+6q9g52cBY8yJLe+Tgw
         YKeqnmG+0a59Q4O5W6kB0BaoEoHytcZMuMGRMwLaSYBBz0c+A+QGK8YnUdMyq8VaCCz4
         z0DCzdKm9Joyyu3pWhbDZZTs44Lx+uEhblaaNNKKq3sVTdEW9QvTVJovM5YjzpRhNXgk
         bJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BYwJF62MfFPS8oc1BGx0H93M3H8BBvu29vXLRwdYmGM=;
        b=Y8IdEXT+tPPUxUXvTwzfLAszMAZqjpbNMkS70IIMHBtBAgRdUzf+9kqT9Yl9if9v/3
         Qc1MTCPcSBvtX2byG5pCALR5FzAVV5UMAGyDjAnxua155XPy1I08e7LUyaDsZvxtqwu5
         kq+orPnA8ZOQoLe0jqmrWXWX9NsyvxHTlQVbKJTpsN3OYvFghsJqM0vnrk68EVlN0eE6
         WycptIKLUrXVfM96/UN5++9/VJRpQh04VFQfNgmK8NhpZdDtK92Ovr39H6e6T9qhVk2H
         jfSy/wfbiSgwkvuN2k1wy5mH88gkMALWI4Xh42JacjAgb9/ZXcVvfL7S+B15l3LDbw0+
         cDTg==
X-Gm-Message-State: AD7BkJJFp1rjx4NjqL43zI5twNQsP5OJpGhthht/r/Zgv/NAIHnjvuRUNGMw1U+o3lLwh5nvKmoX1hI4BHp2uA==
X-Received: by 10.25.83.5 with SMTP id h5mr1242588lfb.45.1456906967204; Wed,
 02 Mar 2016 00:22:47 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Wed, 2 Mar 2016 00:22:17 -0800 (PST)
In-Reply-To: <20160302081344.GB8024@x>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288104>

On Wed, Mar 2, 2016 at 3:13 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Wed, Mar 02, 2016 at 02:30:24AM +0000, Al Viro wrote:
>> On Tue, Mar 01, 2016 at 05:40:28PM -0800, Stefan Beller wrote:
>>
>> > So throwing away half finished stuff while keeping the front load?
>>
>> Throw away the object that got truncated and ones for which delta chain
>> doesn't resolve entirely in the transferred part.
>>
>> > > indexing the objects it
>> > > contains, and then re-running clone and not having to fetch those
>> > > objects.
>> >
>> > The pack is not deterministic for a given repository. When creating
>> > the pack, you may encounter races between threads, such that the order
>> > in a pack differs.
>>
>> FWIW, I wasn't proposing to recreate the remaining bits of that _pack_;
>> just do the normal pull with one addition: start with sending the list
>> of sha1 of objects you are about to send and let the recepient reply
>> with "I already have <set of sha1>, don't bother with those".  And exclude
>> those from the transfer.  Encoding for the set being available is an
>> interesting variable here - might be plain list of sha1, might be its
>> complement ("I want the following subset"), might be "145th to 1029th,
>> 1517th and 1890th to 1920th of the list you've sent"; which form ends
>> up more efficient needs to be found experimentally...
>
> As a simple proposal, the server could send the list of hashes (in
> approximately the same order it would send the pack), the client could
> send back a bitmap where '0' means "send it" and '1' means "got that one
> already", and the client could compress that bitmap.  That gives you the
> RLE and similar without having to write it yourself.  That might not be
> optimal, but it would likely set a high bar with minimal effort.

We have an implementation of EWAH bitmap compression, so compressing
is not a problem.

But I still don't see why it's more efficient to have the server send
the hash list to the client. Assume you need to transfer N objects.
That direction makes you always send N hashes. But if the client sends
the list of already fetched objects, M, then M <= N. And we won't need
to send the bitmap. What did I miss?
-- 
Duy
