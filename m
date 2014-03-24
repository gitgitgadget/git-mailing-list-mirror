From: Ephrim Khong <dr.khong@gmail.com>
Subject: Re: git log omits deleting merges
Date: Mon, 24 Mar 2014 11:25:32 +0100
Message-ID: <5330081C.3090403@gmail.com>
References: <5305B045.2060503@gmail.com> <20140320195404.GA19252@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 11:25:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS24b-00064I-Il
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 11:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbaCXKZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 06:25:36 -0400
Received: from mail-bk0-f44.google.com ([209.85.214.44]:60626 "EHLO
	mail-bk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259AbaCXKZf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 06:25:35 -0400
Received: by mail-bk0-f44.google.com with SMTP id mz13so420678bkb.31
        for <git@vger.kernel.org>; Mon, 24 Mar 2014 03:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xpuqTyCc7WQ6g1N8hRHDTR4+kpu59f42PsawWwdKWlw=;
        b=JAxtUaFLKKXEeMVo2fHmfgfLT3mTc0H0/xvDPhv1kCuXRS1LB4FmQw1ituN3HiBMPk
         XjH4cYpvlYJ8sacMZ7X8GPqxvV05JzHGP5UK2EAEFkqiQ1+H0A+TIu97Xpv8BNmxqpHd
         T2lKdYAOX9uW7Ww/ZAp+eXK24acCvgTLQMeARlBU8iM4MMfB9dHBjMN3CEdogwnBAzrj
         BA+IA5G9LWDdrXh9JeQ2D6wJg3wzCKMHo2K/Bp10ASIEZY38FJ+9Yd7yUPBntwuBp1hF
         xEneKZUhHun0u07AQa/St6hn2RD9KmhAa9txmQZEqquMJdtB669Zq0rL8jD+cHQkjqzn
         IyZQ==
X-Received: by 10.204.59.70 with SMTP id k6mr158177bkh.52.1395656734561;
        Mon, 24 Mar 2014 03:25:34 -0700 (PDT)
Received: from floh-wuff-book.speedport_w723_v_typ_a_1_01_001 (p200300624D236C01DD6186ECB3D35FC3.dip0.t-ipconnect.de. [2003:62:4d23:6c01:dd61:86ec:b3d3:5fc3])
        by mx.google.com with ESMTPSA id es17sm6041556bkb.7.2014.03.24.03.25.33
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 24 Mar 2014 03:25:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <20140320195404.GA19252@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244816>

Am 20.03.14 20:54, schrieb Jeff King:
> On Thu, Feb 20, 2014 at 08:35:33AM +0100, Ephrim Khong wrote:
>
>> Hi, git log seems to omit merge commits that delete a file if --follow or
>> --diff-filter=D is given. Below is a testcase. I'm not sure if it is desired
>> behaviour for --diff-filter=D, but it's probably not correct that --follow
>> _removes_ the merge commit from the log output.
>
> This is by design. Git-log does not calculate or show merge diffs unless
> "-c" or "--cc" is specified, and thus no diff-filter can match.

Thank you for the explanation, I now understand why this is happening 
from a technical point of view. From a usability perspective, it is a 
bit confusing that a flag that should intuitively increase the number of 
shown commits (--follow) removes a commit from the output. Though this 
is just a minor annoyance, so no strong opinion here.

- Eph
