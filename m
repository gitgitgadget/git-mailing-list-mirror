From: work <motroniii@gmail.com>
Subject: Re: [PATCH 1/2] Modified flag field type in rev_list_info struct in
 bisect.h. There is no need for flag field to be signed, as it is not supposed
 to be used as decimal.
Date: Fri, 25 Mar 2016 15:53:36 +0300
Message-ID: <56F534D0.7050104@gmail.com>
References: <1458848469-12663-1-git-send-email-motroniii@gmail.com>
 <1458848469-12663-2-git-send-email-motroniii@gmail.com>
 <CAGZ79kZmzo+f9YF1K1oC2GfOrzdaojmrca7bUm3cBRoDreeA-g@mail.gmail.com>
 <56F44788.2050509@gmail.com>
 <CAPig+cQcviTXYAGBTATgYXoaPtvxxeOUtCGYkLyW5oTFvLjEUA@mail.gmail.com>
 <CAGZ79kaF42yCFWdvqqDSAZbWmUo0UVJGbXCci1LF=ne+cixZ0A@mail.gmail.com>
 <xmqqr3ez5bcf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	sunshine@sunshineco.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 13:53:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajRFK-0003Gp-Hs
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 13:53:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374AbcCYMxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 08:53:41 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33328 "EHLO
	mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbcCYMxk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 08:53:40 -0400
Received: by mail-lf0-f67.google.com with SMTP id w7so5914308lfd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gSO1Vmjrz09SrqFfuu2jfa+fWgICr7hqvFlDU2iGI8Q=;
        b=uj7ChxuX24cMyb7q/FiC6aF9d9Ac3rBBDm3J/quz5/AaKhBP1nRfTfyVfyD2rPAy4s
         tC3XZ+Cf9Jf6XxXm2H9O8/5jaAuojdCuvr9ut5Tk6HFKDprjEBsj05HafMvvjiPUV98S
         1H0skPGOniB26dxVLHFm+8W9dnywTFX7nhu3rd504YmEWp8tQKjdiUeVqSdO5S66bCJy
         Q4OxfpaokLrIIH8mAYWbFOBdgGH85h+MOJhB0RAmD6lvCnK1g75zsr+AgEv2WIlypfqr
         So0ecYMcJJKY9nrStYIL/ecnE4KR58bUNyn4jVSr+bPiH8ZLXN98CokGyw6ODnm+MoU3
         2PEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gSO1Vmjrz09SrqFfuu2jfa+fWgICr7hqvFlDU2iGI8Q=;
        b=A7pAFCARRd0DK5kG5OOwf7XXQTm61PBzPYqZGQG63U8lLHJeotlskkUlv3q/hGHJzn
         MdfcMD0qyF0qTZ3MJYxCyfRUGdcouoHDAR6H1zgZboEXw05U5V9kkd0LA3U6jUNqD4Yp
         B6b+UqdajAf4Wxh6xsn0vJAOrUZrwKpLIaxV8XET/4ACV+iY1K6FJdSoDRf5kjDCG2Sf
         UOMxtM/+hOV1USinIMCUmVUjVsqmebDvPppU1qHAk8D3Df0XlXiyQD1tY+PB1rS3kWjV
         jjTWUP2OdvrMdBEONjnoyJRbdU7e417fx83alqcCosPs9aJYZT6qB+fyRXGMxiPJ6ds7
         AhxQ==
X-Gm-Message-State: AD7BkJJ2tkesXVcK52ENv7t+Ql0ZQe/sByBxgx/zIpv5kxTsIDtINETBbd14p+qfSmLaSg==
X-Received: by 10.25.90.3 with SMTP id o3mr5557624lfb.147.1458910419282;
        Fri, 25 Mar 2016 05:53:39 -0700 (PDT)
Received: from [172.16.163.135] ([109.188.125.28])
        by smtp.gmail.com with ESMTPSA id wj2sm1857154lbb.5.2016.03.25.05.53.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2016 05:53:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
In-Reply-To: <xmqqr3ez5bcf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289885>

Yep. Thanks for your remarks. I have made a bit more research about 
using old rev_list_info struct (with signed int flag) and realized, that 
it doesn't appear in expressions, where using signed integer will differ 
from unsigned one.
I'll take using 'unsigned' instead of 'unsigned int' in account, so if 
needed, I can remake the patch in order to get it accepted.

On 03/25/2016 09:18 AM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Maybe my exposure to the code was accidentally in a way such that
>> I ever only saw the version without int.
> The older part of the code tends to spell flag words with "unsigned"
> without "int", which is primarily historical fault of mine.
>
