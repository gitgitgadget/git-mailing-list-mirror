From: "Jonathan del Strother" <jon.delStrother@bestbefore.tv>
Subject: Re: [PATCH/RFC] Add post-init hook
Date: Wed, 8 Oct 2008 09:16:56 +0100
Message-ID: <57518fd10810080116gd876f9bv169f575087baccd7@mail.gmail.com>
References: <1223421033-22340-1-git-send-email-jon.delStrother@bestbefore.tv>
	 <20081008015352.GA29313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 08 10:18:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnUFH-0003cF-LM
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 10:18:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753392AbYJHIQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 04:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYJHIQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 04:16:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:63664 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbYJHIQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 04:16:56 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3885020wfd.4
        for <git@vger.kernel.org>; Wed, 08 Oct 2008 01:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=YejhAxN9k1RZ9rBuCWww0/j1GIXEj1SAujzxTuiQ5rc=;
        b=YSygPVX+Dhzkvu08LYhTLuDtHv5wcImL7h3jv3jOY3/v0LibVDI3UjyH9+wjDYXMTW
         E+NLd+yLyN97SQZm50gDRELMr4150M/cNzECFJ/KjexmZqxqMDQI1TRkLLA6LhzE9vSG
         xEK2nLC0CFHABv2uYU8oIdbORmj3zszl4KIjg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=QZ9zLfzQSZawtrZspqwP+b1f1vfRc5GelgEMDKw5O85xOO36q2TYpGIg+Lsqu4rxU0
         +X+6jMVD4L1JJYmxTYjTwMlH9dylZVxeOgPsG+DcDdZJw8GLmX2i1gdS76D9s17dMWAQ
         P0dofLpfjaIErCSetOfk9d8YHOyNeGuPZMD54=
Received: by 10.142.128.6 with SMTP id a6mr3269317wfd.236.1223453816206;
        Wed, 08 Oct 2008 01:16:56 -0700 (PDT)
Received: by 10.143.6.3 with HTTP; Wed, 8 Oct 2008 01:16:56 -0700 (PDT)
In-Reply-To: <20081008015352.GA29313@coredump.intra.peff.net>
Content-Disposition: inline
X-Google-Sender-Auth: d12c58fd61fe64e4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97785>

On Wed, Oct 8, 2008 at 2:53 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Oct 08, 2008 at 12:10:33AM +0100, Jonathan del Strother wrote:
>
>> I have a number of hooks that I have to install every time I
>> create/clone a repository.  This patch adds a post-init hook that's
>> perfect for setting up that sort of stuff.
>
> Why is the --template parameter to clone and init not sufficient?
>
 Partly that I never remember to include the --template parameter,
partly that I wanted to customize its behaviour (it copies the files,
I want symlinks so I only have to edit my hooks in one place whenever
I change them)
