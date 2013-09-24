From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] doc: don't claim that cherry-pick calls patch-id
Date: Tue, 24 Sep 2013 15:44:31 -0700
Message-ID: <20130924224431.GU9464@google.com>
References: <1380060333-2226-1-git-send-email-mst@redhat.com>
 <20130924221409.GT9464@google.com>
 <20130924222822.GA2308@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 25 00:44:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VObLU-0006t3-JB
	for gcvg-git-2@plane.gmane.org; Wed, 25 Sep 2013 00:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754213Ab3IXWog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 18:44:36 -0400
Received: from mail-pb0-f51.google.com ([209.85.160.51]:54184 "EHLO
	mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877Ab3IXWof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 18:44:35 -0400
Received: by mail-pb0-f51.google.com with SMTP id jt11so5211872pbb.10
        for <git@vger.kernel.org>; Tue, 24 Sep 2013 15:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=iEkraMA3aOxjGX3gzqpNfVZ10DYilmmBdkd4/uvhP4s=;
        b=x3fp/OdM7AE0i7VunXTTTn/cQaNS06FkVJFNpbzem4KcgZsnzO0Ieye21ANWiaCe1p
         yqSIms6j0BJHNZ1+pgLPaSSpjUpaHQsGcctuyaZRXSs7xbDJSWjrDS+qhuyPvUZ8t5ou
         SXj10yAkf/jsaYvbPUMVzK2wMU6xJjrIgnp/F2bhlosI/o5madGCgQODfBcwSe+5ZFkW
         XlK+GKQ/tR/tQUbIcjR2+ab7VcZlxOY2wljdOpZlJY4sBRAW29J76ehkSwB1k7fxEsSc
         d9CQNzKc55tu1Gh6SuwMNXMQT+JLTM992XT1lpWvJNpwWHYzOzUIeGGOJG+GtE+bTd/Q
         /rRw==
X-Received: by 10.68.197.200 with SMTP id iw8mr152919pbc.197.1380062675451;
        Tue, 24 Sep 2013 15:44:35 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ta10sm48414087pab.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Sep 2013 15:44:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130924222822.GA2308@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235325>

Michael S. Tsirkin wrote:
> On Tue, Sep 24, 2013 at 03:14:09PM -0700, Jonathan Nieder wrote:
>> Michael S. Tsirkin wrote:

>>> -The commits are compared with their 'patch id', obtained from
>>> -the 'git patch-id' program.
>>> +The diffs are compared with their diff id (sha1) calculated after removing
>>> +any whitespace and line numbers (similar but not necessarily identical
>>> +to 'patch id', obtained from the 'git patch-id' program).
>>
>> The hash used internally is just an implementation detail, so maybe this
>> sentence could just be dropped?
>
> I think the fact whitespace is ignored is relevant to users, no?
> We probably should drop talking about hash here.

Ah, good point.  So, something like the following, then?

	Whitespace and line numbers are ignored when comparing the diffs,
	similarly to linkgit:git-patch-id[1].

Maybe some other wording would make it clearer that we are not using
"git diff -w" output.
