From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2014, #05; Mon, 29)
Date: Mon, 5 Jan 2015 12:06:44 -0800
Message-ID: <20150105200644.GJ29365@google.com>
References: <xmqq387yywm6.fsf@gitster.dls.corp.google.com>
 <CAGZ79kbOnX7LVDB8d2Nw0629MvY+ojmy0kDWATM2Zj8NzPRgjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 21:07:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8DvV-0006ou-3i
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 21:06:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbAEUGs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 15:06:48 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:53038 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817AbbAEUGs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jan 2015 15:06:48 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so18451103iec.40
        for <git@vger.kernel.org>; Mon, 05 Jan 2015 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OV2UulRLzglk9Z0jpvnE5uLwyAGTu+uPz6rwXd5X7nU=;
        b=slQCy1Q4V7pranULOY17tG1Z7JHXuY6XaWxLUUDViluVAVBvAMcMBub8zF3bG19HTc
         9NByYmTYMpBkAi9Cpbmt0V/EWBx4VzpkbxLs6GjEpaLugocz8Q64mZ6emNFxI6P/+S4u
         bl0orombk8Ddm15X7E01BcAGsZ/qrP4UNnRy7Cpi6huLdeLP7qY4/HzczOZfacOWVB3G
         mPdHJbJex+Pp6B+JwezLL/iYT8kDF7EX4KHGTsnHRyFlTI6UdBR5Wm0UlOWDdw2dXFrB
         shIam/JDc7w1Y6eYFosRxfiD58vEoK5mVCSRJCcLC3qvh1quZtMxf0kcIT0iM9D7LP43
         Yq/A==
X-Received: by 10.42.199.211 with SMTP id et19mr46349660icb.9.1420488407563;
        Mon, 05 Jan 2015 12:06:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:cbe:c7db:3064:452c])
        by mx.google.com with ESMTPSA id 23sm27046184ioq.1.2015.01.05.12.06.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 05 Jan 2015 12:06:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kbOnX7LVDB8d2Nw0629MvY+ojmy0kDWATM2Zj8NzPRgjQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262030>

Stefan Beller wrote:
> On Mon, Dec 29, 2014 at 1:28 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> * sb/copy-fd-errno (2014-11-17) 1 commit
>>  - copy.c: make copy_fd preserve meaningful errno
>>
>>  Will be rerolled as a part of a larger series.
>
> I am not expecting to reroll this as part of a larger series any more.
> So if this makes sense on its own, please pick it up?

I think the errno-based approach is problematic.  No callers today run
into the problem the patch fixes and if a caller did, I fear that
caller would be broken in other ways.

That said, no one seemed too excited about the alternative that
propagates the error message more explicitly with a strbuf.  I'd be
happy to re-send anyway, or I can work around this patch when
rerolling.

Thanks,
Jonathan
