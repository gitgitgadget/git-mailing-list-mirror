From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Sat, 20 Feb 2016 20:14:35 +0700
Message-ID: <CACsJy8Ci_U+=Nw+9mzebQ1w3xtvb_=TZKyKC4nkRMPjhwDQ-mg@mail.gmail.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
 <20160218085023.GA30049@lanh> <1455827001.7528.87.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 14:15:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX7OA-0007Pm-8A
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 14:15:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758599AbcBTNPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 08:15:09 -0500
Received: from mail-lb0-f172.google.com ([209.85.217.172]:36809 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbcBTNPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 08:15:07 -0500
Received: by mail-lb0-f172.google.com with SMTP id x1so60977236lbj.3
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=JYqbPWYlLO7yMAdOqYZl1WVYplgFdPudeivYMexFUck=;
        b=b8ylNnm73E7QxMH3sl993REH1hldKdhXGg09clxG6k5ml4Fr7l/v55zH5R0O31I2Nm
         BdQQToV4xCZdlA5OMZu6hcLa6Jfsnl/ob4wZ9qzdwqAx/OJg/s/8gfyNvUoj4PxS6iAj
         MyKndmF4sBNv9mEq6Au+2d+Sn+dDyig0HNis1Ucmmvx0CmbsmjkXM54HVjBAFeevizNM
         Ni2zSdhAL4R02AK8K4oLbYvzS6rypBeU7v0FNRaXGZTNwqNY9wunb3xO+GKHswyyw39U
         mlmR3StyuxhFPV6u8QC69tSitIWuZOqgIpJg9JdCv3CrbY4JpANum6xmRMvLKfNKRefN
         VJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=JYqbPWYlLO7yMAdOqYZl1WVYplgFdPudeivYMexFUck=;
        b=XMmOq8pTUelQt8+O63GgctecBiYHTySpdD39BXywVt3TE91Epi8emHtEDOOLN1O8kM
         7dOjz7KSg6s3seXMRgvjI4QemWGe1i5x3nODIqhIwsVBS9wwTn2f+n7Rl1fRO47JjYod
         YJqUPfCtDRA2/h2hbPe1QwFZvYPkCQG/HiXr33HHFWaoDR7sfkjxQzGfGcR6uYnL6M9+
         a0KCe+e9/tIo+kmr/JSWbdsqNpjn85CIiIrvtug1UjE/KonCWUW1WCxhXx3Ruz5ivXzK
         IsLW3ue9rwrH8Bu0+BUmdh5SCWcBKTGlpjb7++dJTyZ92HldO/MS5cFgQbJ0tcBCgrgf
         Ie/Q==
X-Gm-Message-State: AG10YOSRiJwEhbQZ0GzYX5lZ26ALFx5wMIszz4EwRTe1V3dLsRIdggl+aIE3FAnIpTEppeR+t+H6UR43ppZn2w==
X-Received: by 10.112.167.162 with SMTP id zp2mr7107748lbb.3.1455974105015;
 Sat, 20 Feb 2016 05:15:05 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Sat, 20 Feb 2016 05:14:35 -0800 (PST)
In-Reply-To: <1455827001.7528.87.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286780>

On Fri, Feb 19, 2016 at 3:23 AM, David Turner <dturner@twopensource.com> wrote:
> On Thu, 2016-02-18 at 15:50 +0700, Duy Nguyen wrote:
>
> [snip]
>
> Thanks; applied the above
>
>> This permission makes me wonder if we need adjust_shared_perm() here
>> and some other places.
>
> So just add this after every mkdir?
>
>         if (shared_repository)
>                 adjust_shared_perm(db_path);
>

Another option is avoid mkdir entirely. Getting started page [1] says
if you do mdb_open_env(.., "refs.lmdb", MDB_NOSUBDIR,..) then it will
create two files refs.lmdb and refs.lmdb.lock. No need for the
directory "refs.lmdb" just to contain two files.

[1] http://symas.com/mdb/doc/starting.html
-- 
Duy
