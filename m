From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitk next/prev buttons
Date: Tue, 8 Oct 2013 12:36:19 -0700
Message-ID: <20131008193618.GE9464@google.com>
References: <524A33E5.7090001@threeamdesign.com.au>
 <525445FB.6000806@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Lucas Sandery [three am design]" <lucas@threeamdesign.com.au>,
	git@vger.kernel.org, Paul Mackerras <paulus@samba.org>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Oct 08 21:36:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VTd53-0005kI-Qp
	for gcvg-git-2@plane.gmane.org; Tue, 08 Oct 2013 21:36:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931Ab3JHTg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Oct 2013 15:36:27 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46099 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787Ab3JHTgX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Oct 2013 15:36:23 -0400
Received: by mail-pa0-f52.google.com with SMTP id kl14so9272231pab.39
        for <git@vger.kernel.org>; Tue, 08 Oct 2013 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=bzGgza6mUkOuS0iyobsvR9TeamHZSUgkTnVm0wxdXk8=;
        b=m+u/7FC1PtKEzsdp1IxfPCdHYduCnjBpxJGlnJZWepUtRm/5RMg/FMgnIqiiY+TNSy
         ORaXRp2lzgpOHfKHan++ZLue5CGni9Ua/4YO94WBIVM7sfbN+ch56gnklfm6KGvqiCpo
         pfWjYUJ+EydeWvHRmacOOWbxFIaOrH8CIaeUWg069h5nOVWSG/WS2doEnPPHHkPx71V8
         44TJ2dbjhaexNiGnbEzCpSktcJfjvIYv3CbjMu6QZ6DN5sxVifYuyAo7nmd5lnM+aQuo
         4awid4xD6R7scWj/0qjp1u4/gjto+cXCfmW367l45KkmkmylqF71H0K2hXpMwdlY2oZ6
         4VeA==
X-Received: by 10.68.185.68 with SMTP id fa4mr3870913pbc.136.1381260983034;
        Tue, 08 Oct 2013 12:36:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id so2sm41842167pbc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 08 Oct 2013 12:36:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <525445FB.6000806@xiplink.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235784>

Hi,

Marc Branchaud wrote:
> On 13-09-30 10:31 PM, Lucas Sandery [three am design] wrote:

>> The "next" and "prev" buttons are lacking consistency and logic. For LTR
>> languages previous is almost always on the left, and next on the right. The
>> words are contradictory, "next" actually goes to backwards chronologically,
>> and "prev" goes forward. Could the positions of the buttons be switched and
>> the text be replaced with "earlier" and "later"? This would make the
>> reference time not just order, and would mean the updated UI would not be
>> confused with the previous one.
>
> I agree with you here (I like "older" and "newer" myself).
>
> In theory gitk accepts the same arguments as "git rev-list", and in theory
> you should be able to use things like --reverse to get the commits in a
> different order.
>
> However, in practice I don't think anyone futzes with the ordering much with
> gitk.  gitk even ignores the --reverse and --timestamp options, and I've had
> a hard time getting gitk to display commits in an order where "older" and
> "newer" would not make sense.

In a branchy history, it is possible for the next matching commit to
actually be newer.  I think the intent of the buttons is "find the
next result, looking down or up in the list of commits in the upper
pane".  Is there some other wording that would convey this better?

>> Also, the arrow-only next/previous buttons (beside the commit ID) should
>> really point up and down. Horizontal directions are ambiguous for navigation
>> of a vertical list.
>
> Here I don't agree.  These arrows are purely about history navigation.  They
> don't have anything to do with "up" or "down" in the list.  In that sense
> they're more like the arrows in your web browser.

True.  It might make sense to make the analogy to a web browser
clearer by using thicker arrows or triangles --- care to mock up icons
to replace the current ones?

The icons are in the gitk source file (search for "bm_left_data") in
xpm format.

Hope that helps,
Jonathan
