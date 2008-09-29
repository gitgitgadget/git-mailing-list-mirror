From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/6] gitweb: use_pathinfo filenames start with /
Date: Tue, 30 Sep 2008 01:20:01 +0200
Message-ID: <200809300120.02492.jnareb@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com> <200809290308.09312.jnareb@gmail.com> <cb7bb73a0809290712g324ec015r70fd868b91673645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@ucw.cz>,
	"Lea Wiemann" <lewiemann@gmail.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 30 01:21:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkS3L-0004vo-Sg
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 01:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752052AbYI2XUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Sep 2008 19:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbYI2XUG
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Sep 2008 19:20:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:7618 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbYI2XUF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Sep 2008 19:20:05 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1586347fgg.17
        for <git@vger.kernel.org>; Mon, 29 Sep 2008 16:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=15pifbWjV6Z61YmgfstMyXlyHY1wufK2oMjGKR32aMo=;
        b=jcqQuVg8/S1lOeoPxNCCuTlNApmLevsKmpeGmK48Xm+zGp0ORLtV0wn0ZrEM2+CMLr
         wJ6qIscr7QsunXeK3AgBHulWJwP3IY8GkYodh6szusAiJMuBVRacbUrQKfOjdjG5fMbC
         sWxlz3rkaP756WqwQmN3uzVEXo2cAD7VOKtyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=byp+CJIuZVWaBXYWfKE1AgbRqO2OQSMUKWsoxVrgvMHrDrIc61MlyGXrgj0qLjqu1B
         HFMnjpj/EEXrCvI1/EbL117pDN4mLVq7s0TJ9zjWi0ZAtBDMQpJiTuWt41B4qTIyQ4/x
         mjAxxn4JAMYIgQbSphh55aWCTnKjSmijT4rH8=
Received: by 10.86.80.5 with SMTP id d5mr4924231fgb.26.1222730403735;
        Mon, 29 Sep 2008 16:20:03 -0700 (PDT)
Received: from ?192.168.1.11? (abvy102.neoplus.adsl.tpnet.pl [83.8.222.102])
        by mx.google.com with ESMTPS id 4sm1777855fge.8.2008.09.29.16.20.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Sep 2008 16:20:02 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0809290712g324ec015r70fd868b91673645@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97057>

On Mon, 29 Sep 2008, Giuseppe Bilotta wrote:
> On Mon, Sep 29, 2008 at 3:08 AM, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Sun, 21 Sep 2008, Giuseppe Bilotta wrote:

>>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>>> index e783d12..18da484 100755
>>> --- a/gitweb/gitweb.perl
>>> +++ b/gitweb/gitweb.perl
>>> @@ -664,7 +664,7 @@ sub href (%) {
>>>               if (defined $params{'hash_base'}) {
>>>                       $href .= "/".esc_url($params{'hash_base'});
>>>                       if (defined $params{'file_name'}) {
>>> -                             $href .= ":".esc_url($params{'file_name'});
>>> +                             $href .= ":/".esc_url($params{'file_name'});
>>>                               delete $params{'hash'} if $params{'hash'} eq git_get_hash_by_path($params{'hash_base'},$params{'file_name'});
>>>                               delete $params{'file_name'};
>>>                       } else {
>>> --
>>> 1.5.6.5
>>
>> Is there reason why this change is separate (not squashed) from
>> previous commit?
> 
> Historical reason (i.e. I came up with the idea later on). I'll squash it.

Hn. Now I am not sure if it should be squashed, or should be separate.


Good change.

Please don't forget to describe this decision, i.e. why gitweb is
using "branch:/filename" when creating path_info links instead of
simple "branch:name" for relative URLs in HTML in 'raw' ('blob_plain')
view, in the commit message.  Thanks in advance.

-- 
Jakub Narebski
Poland
