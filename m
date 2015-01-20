From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 15/18] fsck: Document the new receive.fsck.* options.
Date: Tue, 20 Jan 2015 08:24:51 +0100
Organization: gmx
Message-ID: <af8b0ce029243f91e048d474c780b466@www.dscho.org>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421682369.git.johannes.schindelin@gmx.de>
 <41d4880fc48ad39d4798c2f9a0cb38a6a41c41b3.1421682369.git.johannes.schindelin@gmx.de>
 <CAPig+cSVUAV_6c0Zv36aA++AWCG05yxq-LpPsQ89VoepHGUBRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	ericsunshine@gmail.com
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:25:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDTBd-0006cK-L8
	for gcvg-git-2@plane.gmane.org; Tue, 20 Jan 2015 08:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbbATHZJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2015 02:25:09 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]:43289 "EHLO
	s15462909.onlinehome-server.info" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752507AbbATHZF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jan 2015 02:25:05 -0500
Received: from s15462909.onlinehome-server.info (localhost.localdomain [127.0.0.1])
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id t0K7OpVV010104;
	Tue, 20 Jan 2015 08:24:51 +0100
Received: (from www-data@localhost)
	by s15462909.onlinehome-server.info (8.14.4/8.14.4/Submit) id t0K7OpA2010103;
	Tue, 20 Jan 2015 08:24:51 +0100
X-Authentication-Warning: s15462909.onlinehome-server.info: www-data set sender to johannes.schindelin@gmx.de using -f
X-PHP-Originating-Script: 1000:rcube.php
In-Reply-To: <CAPig+cSVUAV_6c0Zv36aA++AWCG05yxq-LpPsQ89VoepHGUBRw@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262649>

Hi Eric,

On 2015-01-19 23:44, Eric Sunshine wrote:
> On Mon, Jan 19, 2015 at 10:51 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
>> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> ---
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ae6791d..7371a5f 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -2130,6 +2130,31 @@ receive.fsckObjects::
>>         Defaults to false. If not set, the value of `transfer.fsckObjects`
>>         is used instead.
>>
>> +receive.fsck.*::
>> +       When `receive.fsckObjects` is set to true, errors can be switched
>> +       to warnings and vice versa by configuring the `receive.fsck.*`
>> +       settings. These settings contain comma-separated lists of fsck
>> +       message IDs. For convenience, fsck prefixes the error/warning with
>> +       the message ID, e.g. "missing-email: invalid author/committer line
>> +       - missing email" means that setting `receive.fsck.ignore =
>> +       missing-email` will hide that issue.
>> ++
>> +--
>> +       error::
>> +               a comma-separated list of fsck message IDs that should be
>> +               trigger fsck to error out.
>> +       warn::
>> +               a comma-separated list of fsck message IDs that should be
>> +               displayed, but fsck should continue to error out.
>> +       ignore::
>> +               a comma-separated list of fsck message IDs that should be
>> +               ignored completely.
>> ++
>> +This feature is intended to support working with legacy repositories
>> +which would not pass pushing when `receive.fsckObjects = true`, allowing
>> +the host to accept repositories certain known issues but still catch
> 
> s/certain/with &/

Good catch. Fixed here (to be included in the next re-roll):

https://github.com/dscho/git/commit/2517476646835e61c33581935fc68062a8ff3f56#diff-ba92ef40c548c691816362bbdc35a613R2155

Thanks!
Dscho
