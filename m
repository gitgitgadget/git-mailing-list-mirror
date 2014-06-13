From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 0/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 15:24:52 -0700
Message-ID: <CAL=YDWnGBrgHFamc0ZmmGJSFL3Z_6ZaWn4AWOMhJTPQ5UCKD_A@mail.gmail.com>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com>
	<xmqqa99h6hbh.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=xn0OG5vu=9fnP0nycKV0F9bDJLrkYiwmL9P9q79LJSw@mail.gmail.com>
	<CAL=YDWnHubbC3eOUjHtbiddG0HiaNUW13=GRMXKfyxB+Yomq_g@mail.gmail.com>
	<xmqqk38k1pmv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 00:25:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZu5-0005D5-U6
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jun 2014 00:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbaFMWYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 18:24:54 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:57992 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbaFMWYx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 18:24:53 -0400
Received: by mail-vc0-f175.google.com with SMTP id hy4so2877564vcb.20
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0+1va79QDHHjKQZykpVqfLQTOJb9qMq1ZmMuqSXQo7A=;
        b=Ye5/Ka9upQUmeIqnjBGh17ipeL9Vnu5jc+m+SH5K1n2K9sBFM4Fr1sW0XuInvQeI0f
         gqrViwVzBAshvyXvJZvV+Q1/rCKvHPsUQuJLIv/rLVYIcIT0ggO4r2MBSoQkZDdMguVz
         hVVa8WLdINb7Vbn8MQKM46Q5RkogR872j9cK2kInGTkfY17epbWSKWDOYEi4jyufYx7H
         Mzvsr/Oq73DPLzFBCge7kukRa2t5mHuVYXA3F/Ua7jm7clOhKOhD0wsAuePzMyWwNimN
         crk2T1xsE4CvQG9J98Y537o9pz2aUlB5s9WWHesSTTw+W2EwP+TYFP/0qer2Jt6TfwMj
         MPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=0+1va79QDHHjKQZykpVqfLQTOJb9qMq1ZmMuqSXQo7A=;
        b=b/HgdH5xVS/NESGyB11kLdqIfKA+4SDs13NNEWP6lCFHPR9DIEeY08qIgyArIKjhK2
         0vO8sYfi1e87+2AwULKANfEfpOoBZn0WUOM2osJX31nUiqe2Hm75xaAOHDusFrI7srSx
         KHlaVnTUeLwUgDDwFDB7TZOHhItPnAknBqImgkSj1L7KKu9Dl5rrnyTUxweimOwW0gD8
         akkeGySaO3BQsBmUHLhvhscfQky+eqR9RcDR02hYgC1f8fEvzmA2F2lQSDMNaTVLmRKx
         9qdsLEOpoQDD3nWraS5H7tlZdvf+/iYLx1or9oUd3bRtn/sC8VQorbyFoLFYBAGhLzO3
         4Gtg==
X-Gm-Message-State: ALoCoQmWRlMvRqngJkGfx25q5whWlNDEmnX+qsyAfFc+5cZZklwNExDlWbT39jtJXLPcd07gyqRB
X-Received: by 10.58.133.6 with SMTP id oy6mr3602850veb.25.1402698292508; Fri,
 13 Jun 2014 15:24:52 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Fri, 13 Jun 2014 15:24:52 -0700 (PDT)
In-Reply-To: <xmqqk38k1pmv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251645>

On Fri, Jun 13, 2014 at 2:11 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ronnie Sahlberg <sahlberg@google.com> writes:
>
>> ... The first
>> backend will be the current files based structure but I also will add
>> an optional backend using a TDB database.
>
> I am assuming that as part of the transactions work, accesses to
> reflogs will also have their own backends?

Yes. They will be stored in the same database so that updates to refs
and reflogs will become truly atomic.

>
>> You could then very easily create a new backend, say 'struct refs_be
>> refs_files_case_insensitive' where the methods would just convert any
>> refnames to/from a case insensitive encoding before invoking the
>> default methods from the files backend.
>> Perhaps something as simple as converting any upper case characters
>> to/from '%xx' representation when accessing the actual files.
>
> Hmm... that would work only when the new implementation of Git is
> the only one that accesses the repository.  Other implementations
> (e.g. Eclipse via egit, Gerrit via jgit, etc.)  peeking into the
> same repository wouldn't know what to do with these encoded
> refnames.
