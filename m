From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Tue, 11 Jan 2011 08:56:09 +0700
Message-ID: <AANLkTimcmxMxgswrQcqex8b8M717LmTctj=3i7jEHOhZ@mail.gmail.com>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com>
 <4D2B3643.2070106@gmx.de> <AANLkTimh1RRnjXjg-fw_-RQxNW_fLbSYis8n2BvNaCc+@mail.gmail.com>
 <4D2BAB0A.1060909@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Wyzer <john.wyzer@gmx.de>, git@vger.kernel.org
To: "J.H." <warthog9@kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 11 02:56:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcTTb-0006XC-2r
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 02:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab1AKB4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 20:56:42 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44840 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150Ab1AKB4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 20:56:41 -0500
Received: by wwa36 with SMTP id 36so1271172wwa.1
        for <git@vger.kernel.org>; Mon, 10 Jan 2011 17:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=J49yv8Q+S6m7SmmX5BXNLEKsQOboVQEO8E0oDoQnDf8=;
        b=ujRYKdqeKELXd8ItAoYGOYvJy4iiuSquwRZZAk30bzZR0PCY7BubNAY2ciC0AwF+kW
         201pu8gmxb5NLVEDQBMBOb8+A/JxuS5QkMmswOl4Ih6E+tjGf2kNWou/nbid/FxFYmpf
         js92K8j0FFizzE2un7MOigfwNyB5OAXaLGGWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rtkAOeHfNtNM+Kde9wGFOsbRYQYLRYNUtUHZWtVor02UgLRqN/FVDlxk9uFeTzE47e
         raflk5YI7WP4oKXn0JNPvLu2Iaom8k90it6EvN6FvfZsosOGwdIkfnDVzOLeBmcs4fs+
         n/aB8i6w54e8FRCjjMG7M1aQQnXCQIwJrK1F4=
Received: by 10.216.169.71 with SMTP id m49mr1199626wel.4.1294710999884; Mon,
 10 Jan 2011 17:56:39 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Mon, 10 Jan 2011 17:56:09 -0800 (PST)
In-Reply-To: <4D2BAB0A.1060909@kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164906>

On Tue, Jan 11, 2011 at 7:57 AM, J.H. <warthog9@kernel.org> wrote:
> On 01/10/2011 04:03 PM, Nguyen Thai Ngoc Duy wrote:
>> On Mon, Jan 10, 2011 at 11:39 PM, John Wyzer <john.wyzer@gmx.de> wrote:
>>> Why not provide an alternative mode for the git:// protocoll that instead of
>>> retrieving a big packaged blob breaks this down to the smallest atomic
>>> objects from the repository? Those are not changing and should be able to
>>> survive partial transfers.
>>> While this might not be as efficient network traffic-wise it would provide a
>>> solution for those behind breaking connections.
>>
>> That's what I'm getting to, except that I'll send deltas as much as I can.
>
> While I think we need to come up with a mechanism to allow for resumable
> fetches (I'm thinking slow sporadic links and larger repos like the
> kernel for instance), but breaking the repo up into too small a chunks
> will very adversely affect the overall transfer and could cause just as
> much system thrash on the upstream provider.
>
> I'd be curious to see what the system impact numbers and performance
> differences are though, as I do think getting some sort of resumability
> is important, but resumability at the expense of being able to get the
> data out quickly and efficiently is not going to be a good trade off :-/

Yeah, I'm interested in those numbers too. Let me get a prototype
working, then we'll have numbers to discuss.
-- 
Duy
