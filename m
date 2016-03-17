From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v2] hashmap API: introduce for_each_hashmap_entry() helper
 macro
Date: Thu, 17 Mar 2016 23:39:19 +0100
Message-ID: <56EB3217.7090907@gmail.com>
References: <1458211127-26963-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 23:39:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aggZn-000104-5T
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 23:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031491AbcCQWj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 18:39:26 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32769 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030634AbcCQWjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 18:39:25 -0400
Received: by mail-wm0-f67.google.com with SMTP id x188so2336318wmg.0
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 15:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=6QtfvSvYpn3VQs6sPndv4N63o1HNr5DmyijGBIQL1j8=;
        b=BXhgHc7Cd0+BHW84u4aPng4VHdFXjmXAK2Blxuw8wat1aRpq53cGY0+SzWaDiPliH8
         I1nMUROICok+9phhW1zX5sI4cCQzJ2CnTHt3eWelMdNiOvl0WGlW89DO4vv5iB7/SAkl
         1+7B4UD4AOI0JMYsUEIF5ZlaGZx9MxO5Bxmx6x9O9bfAuPXbvJI3WzD6GxyAlcrmpEYB
         0FY/SeKUNjyf7xJ7L9r+4sgUlfgzQIvohMtJoJu+qBFxZev6VzYcYwTNlayOlxSxWJEA
         kpP67fds124OBJay6sDER2mcE3JaAUtM/wm2mxJYSbUyDOCgYI1MCfTI74k25PXxTS5H
         sHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=6QtfvSvYpn3VQs6sPndv4N63o1HNr5DmyijGBIQL1j8=;
        b=XeAbicqCwTXQE/gLcGtqLjHOyUrea8OTYd3cLdBAc71CyQCUn7FZLtOgibJ07jUCsu
         SQHL7r4VJomIZzXwhuwGaqWQ4VCcd+KSmaiBTIMMuikySTEwogbygxsbh9fMnqyDdp6k
         IKdm2IE91WVArZ+fsmt2emGMlzFB+91ERFh4nnfDWQ8ElcTo9wo0I6p4FkNioHHvOBit
         YJPR0E3TFRIuNajudIuBywAdvtefHHQuc7jznwfblHdnwz4sGnS528DMaeLl7nOrHu6r
         ILzYKryDh/l/Z5tPAmv6tovqTeynChHqqB/QGBXwohQi9ivLmX+MJtMgTePMr7ebbe0t
         oEkA==
X-Gm-Message-State: AD7BkJKdTRttV9KMrYcUJMx/Yb3DRweb46olbF8YRhwLFXcUl8+PyRpqP8DSrNBZfH+gPg==
X-Received: by 10.194.94.229 with SMTP id df5mr14146648wjb.133.1458254364124;
        Thu, 17 Mar 2016 15:39:24 -0700 (PDT)
Received: from [10.1.116.53] (ns.dcon.de. [77.244.111.149])
        by smtp.googlemail.com with ESMTPSA id i2sm9616562wje.22.2016.03.17.15.39.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 17 Mar 2016 15:39:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <1458211127-26963-1-git-send-email-kuleshovmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289164>

Am 17.03.2016 um 11:38 schrieb Alexander Kuleshov:

> This patch introduces the for_each_hashmap_entry() macro for more

I'd rather call it 'hashmap_for_each', following the pattern
'operandtype_operation' used throughout git. E.g. we already have
'hashmap_get', not 'get_hashmap_entry'.

I realize that existing *for_each* implementations in the git code
base are a bit of a mess (except 'sha1_array_for_each_unique'). E.g.
there is 'for_each_string_list' and 'for_each_string_list_item'. Both
loop over the string_list_items of a string_list, but one is named
after the collection type, the other after the item type...IMO this
shouldn't set an example for future code.

The rest of the patch looks good to me.
