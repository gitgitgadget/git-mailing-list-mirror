From: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
Subject: Need your help with MinGW Issue 17: --color options don't work (produce garbage)
Date: Tue, 14 Aug 2007 23:29:41 -0700
Message-ID: <a1bbc6950708142329w4e0e3d7cq573c67dd3b28f03a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: msysGit <msysgit@googlegroups.com>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 15 08:30:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILCOF-00084p-Sl
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 08:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbXHOG3n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 02:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752364AbXHOG3n
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 02:29:43 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:40007 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbXHOG3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 02:29:42 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1648992rvb
        for <git@vger.kernel.org>; Tue, 14 Aug 2007 23:29:41 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L++jmw6jO1HX6kqRI2HTV8mIT+Ib7Zfiy02/0eQ28OH1fOn+4e+9NXlV1FoeLN1El0IClOHQiB/ynktRVzssI+htGVT0uReI60/KNzkegcTjoKIZeoWip9slagu37bBCxqVFoGGmTtsupRb5G6bvUsGEG+onHFWh+Ymns1E0RQs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=mpdaZ79+UTYQk9VwQIebmvNE2k7SKpzkYeFQ2khBvUzhXt/JFHqBnlP1cd0ludY2NoqVnKc1Q+Uuo176bXb6l+dXguVSgfk+z1rY8/zbjQt54z6L1vcBE+fRUO4xSg6kJYSD1JRd76MDk4H54EQMi+c/MHU6blqhNsb2kNW+zbs=
Received: by 10.140.251.1 with SMTP id y1mr71027rvh.1187159381673;
        Tue, 14 Aug 2007 23:29:41 -0700 (PDT)
Received: by 10.141.21.17 with HTTP; Tue, 14 Aug 2007 23:29:41 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55883>

Here are the facts:

'git branch --color' produces garbage:
$ git branch --color
  devel←[m
  dima←[m
  dmitryk←[m
* ←[32mmaster←[m
  mob←[m
  next←[m

'git branch --color | cat' produces expected colored output.

I've traced it down to printf statement in gdb and it sends the right
esc-sequence.
Where should I look next?

(little bit) more info here:
http://code.google.com/p/msysgit/issues/detail?id=17

-- 
- Dmitry
