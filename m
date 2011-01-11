From: "J.H." <warthog9@kernel.org>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Mon, 10 Jan 2011 16:57:46 -0800
Message-ID: <4D2BAB0A.1060909@kernel.org>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com> <AANLkTinc12H01Us1mkKieZo75hwjgTCZth_wFvRNscMq@mail.gmail.com> <4D2B3643.2070106@gmx.de> <AANLkTimh1RRnjXjg-fw_-RQxNW_fLbSYis8n2BvNaCc+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: John Wyzer <john.wyzer@gmx.de>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 01:57:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcSYf-00049C-QZ
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 01:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755208Ab1AKA5w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jan 2011 19:57:52 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:52313 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816Ab1AKA5v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jan 2011 19:57:51 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id p0B0vk5U013774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 10 Jan 2011 16:57:47 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <AANLkTimh1RRnjXjg-fw_-RQxNW_fLbSYis8n2BvNaCc+@mail.gmail.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 10 Jan 2011 16:57:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164905>

On 01/10/2011 04:03 PM, Nguyen Thai Ngoc Duy wrote:
> On Mon, Jan 10, 2011 at 11:39 PM, John Wyzer <john.wyzer@gmx.de> wrote:
>> Why not provide an alternative mode for the git:// protocoll that instead of
>> retrieving a big packaged blob breaks this down to the smallest atomic
>> objects from the repository? Those are not changing and should be able to
>> survive partial transfers.
>> While this might not be as efficient network traffic-wise it would provide a
>> solution for those behind breaking connections.
> 
> That's what I'm getting to, except that I'll send deltas as much as I can.

While I think we need to come up with a mechanism to allow for resumable
fetches (I'm thinking slow sporadic links and larger repos like the
kernel for instance), but breaking the repo up into too small a chunks
will very adversely affect the overall transfer and could cause just as
much system thrash on the upstream provider.

I'd be curious to see what the system impact numbers and performance
differences are though, as I do think getting some sort of resumability
is important, but resumability at the expense of being able to get the
data out quickly and efficiently is not going to be a good trade off :-/

- John 'Warthog9' Hawley
