From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when recursing
Date: Tue, 2 Nov 2010 21:40:18 -0700
Message-ID: <5BE96A08-B8AB-4041-ABF2-7095EB5DD585@sb.org>
References: <1288758882-77286-1-git-send-email-kevin@sb.org> <20101103043725.GA10311@burratino>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 05:40:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDV98-00052M-7H
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 05:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab0KCEkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 00:40:22 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41692 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750793Ab0KCEkV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 00:40:21 -0400
Received: by pvb32 with SMTP id 32so71243pvb.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 21:40:20 -0700 (PDT)
Received: by 10.142.157.21 with SMTP id f21mr5706050wfe.5.1288759220517;
        Tue, 02 Nov 2010 21:40:20 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id w22sm12509088wfd.19.2010.11.02.21.40.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 21:40:19 -0700 (PDT)
In-Reply-To: <20101103043725.GA10311@burratino>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160575>

On Nov 2, 2010, at 9:37 PM, Jonathan Nieder wrote:

> Hi Kevin,
> 
> Kevin Ballard wrote:
> 
>>           It's also a reasonable model for how to handle this problem
>> in other shell commands.
> 
> This caught my attention. :)
> 
>> +# Emit a quoted version of the all argument suitable for passing to `eval`
>> +# $@ = words to quote
>> +#
>> +# This is intended to be used like the following:
>> +#   orig_args="$(quote_words "$@")"
>> +#   # do some work that includes calling shift
>> +#   eval "set - $orig_args"
>> +#   # now $@ has been restored, suitable for passing to another command
>> +#
>> +# Note that you cannot simply save off $@ into another variable because
>> +# the shell gives $@ and $* special handling in parameter expansion
>> +#
>> +quote_words ()
> 
> Have you looked into "git rev-parse --sq-quote"?

Well crud, I wish I'd seen that before. Looks like it does pretty much the
exact same thing as my quote_words function. I'll send out another patch
that uses this instead of quote_words. Thanks for the info!

-Kevin Ballard