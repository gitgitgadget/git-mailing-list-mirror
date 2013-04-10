From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Wed, 10 Apr 2013 14:23:29 -0700
Message-ID: <20130410212329.GD27070@google.com>
References: <7vobdnnpx6.fsf@alter.siamese.dyndns.org>
 <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org>
 <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org>
 <20130410185958.GA22394@sigill.intra.peff.net>
 <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
 <CALkWK0k44+VnrGTXESdap2nRomdYH8xwz_T2JdhYtSrPR+89sw@mail.gmail.com>
 <20130410200512.GB27070@google.com>
 <20130410201103.GD24177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Duy =?utf-8?B?Tmd1eeG7hW4=?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:23:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2UW-0006tP-6p
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760269Ab3DJVXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:23:36 -0400
Received: from mail-da0-f43.google.com ([209.85.210.43]:38517 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab3DJVXf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:23:35 -0400
Received: by mail-da0-f43.google.com with SMTP id u36so383501dak.30
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=QuF4dmRUFhxxdoAfuoCF7CQZNRkC5dcj9BGFXEnEbSg=;
        b=JnOqzn9LUyR7wtFwMxRlitD6fejhhA+AwrqVNe2Sto3KyzqnqAybSc7KVLC+jEu4ri
         v7rYKFDVp0Tsm6fbeSCSkL+nRs+h/3bUUgbFdEwEbSjs0/V2MgF7QR7doFb/UBLBZm5X
         xsm1EScqaohwyPXDvWexAi7ZrNrcGDDrAwGCNRX/ZrGaGfol+C0bUo3uGFLUnM8cXrII
         9nQNmz8RYXSzzOPfLLvutgPVZe3YmEg90dOBSWaJMGXT9QeHKxEyDqusFLvLtxPTPo5P
         0FLbcgYzOWMslPrssIBo1FJWpn5xVKVO5W+cckF4M0MLzkVZ/e4jzUVsZSaOxVzLjCyG
         DzdQ==
X-Received: by 10.66.26.44 with SMTP id i12mr5946220pag.151.1365629014880;
        Wed, 10 Apr 2013 14:23:34 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id wi6sm1294871pbc.22.2013.04.10.14.23.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 14:23:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130410201103.GD24177@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220771>

Jeff King wrote:
> On Wed, Apr 10, 2013 at 01:05:12PM -0700, Jonathan Nieder wrote:

>> 	git push
>>
>> and "[push] default = upstream", then it is obvious what the user
>> wanted to happen.  But what about when "[push] default = matching"?
>> Which of the following behaviors is correct?
>>
>>  a) Error: you didn't tell me which remote to push to.
>>  b) Just behave like "git push my-personal-remote :".
>>  c) Ignore which branch is the current branch and behave like
>>     "git push origin :".
>>
>> How about when "[push] default = current"?
>>
>> Except that people might have scripts or habits tied to the current
>> behavior, any of (a), (b), and (c) sounds fine to me.  (b) is the
>> obvious choice for historical reasons.
>
> I think (b) could be quite surprising to a user. I suspect it hasn't
> come up because people just don't work with a lot of different remotes
> in practice.

Yeah, I think you're right.

I'll try writing a series to switch to (c) for [push] default = matching
and (a) for default = simple (and one of the two for default = current.
Not sure which yet).

Thanks,
Jonathan
