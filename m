From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 4/4] contrib: add convert-grafts-to-replace-refs.sh
Date: Mon, 02 Jun 2014 21:16:02 +0200 (CEST)
Message-ID: <20140602.211602.2254580887425712957.chriscool@tuxfamily.org>
References: <20140601150409.15428.27017.chriscool@tuxfamily.org>
	<20140601151038.15428.20661.chriscool@tuxfamily.org>
	<CAPig+cTjJHRDQFckLqRCW0xHkMFLVbuYGrLCWHXZQoFsYY5WwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	jnareb@gmail.com
To: sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Mon Jun 02 21:16:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrXiP-0006Gd-F1
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751507AbaFBTQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:16:07 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:38784 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbaFBTQG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:16:06 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 7A6C066;
	Mon,  2 Jun 2014 21:16:03 +0200 (CEST)
In-Reply-To: <CAPig+cTjJHRDQFckLqRCW0xHkMFLVbuYGrLCWHXZQoFsYY5WwA@mail.gmail.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250582>

From: Eric Sunshine <sunshine@sunshineco.com>

> On Sun, Jun 1, 2014 at 11:10 AM, Christian Couder
> <chriscool@tuxfamily.org> wrote:
>>
>> +test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
>> +
>> +grep '^[^# ]' "$GRAFTS_FILE" | while read definition
>> +do
>> +       test -n "$definition" && {
>> +               echo "Converting: $definition"
>> +               git replace --graft $definition ||
>> +                       die "Convertion failed for: $definition"
> 
> s/Convertion/Conversion/  [1]
> 
> [1]: http://git.661346.n2.nabble.com/Re-PATCH-contrib-add-convert-grafts-to-replace-refs-sh-tp7611822.html

Ooops, sorry I forgot this.
 
>> +       }
>> +done
>> +
>> +mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
>> +       die "Could not mv '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
> 
> "Could not rename..." might be a bit more friendly to non-Unixy folk.

Ok, I will use "rename".

Thanks,
Christian.
