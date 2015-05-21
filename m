From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Troubleshoot clone issue to NFS.
Date: Thu, 21 May 2015 21:38:30 +0700
Message-ID: <CACsJy8Cs6GcRQ-kgnSqwxP4MPHfds9qiir1_O1hc5cZ+0QP-EA@mail.gmail.com>
References: <7FAE15F0A93C0144AD8B5FBD584E1C5519758FC3@C111KXTEMBX51.ERF.thomson.com>
 <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: steve.norman@thomsonreuters.com
X-From: git-owner@vger.kernel.org Thu May 21 16:39:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvRcq-00021M-44
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 16:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbbEUOjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 10:39:04 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38368 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753638AbbEUOjB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 10:39:01 -0400
Received: by igcau1 with SMTP id au1so10113378igc.1
        for <git@vger.kernel.org>; Thu, 21 May 2015 07:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=q6NtS3B2ZgRiR9p47AjdwSUNQlu2DOUb4ADBEf5/pHc=;
        b=zoN/cIWNTPgZtLBv48drR6ePGpEdPJzUG9lhQTIlNl+KtJIXIbzMgHbcH+4MBRBAIp
         rvtesZjreDw2+CqV2fqNX7oPX6fHJYmzA9Oo35EzqmL5ZYeQykHx6Kpv2gIupylyjVUR
         SwZXwqt6atWtc17BCzMFIISq7Si86pIMrAePEaFSfL1zbhQrADVOWZov97ahuYsIkWkD
         FX6GXazmnQFxmUjHv4BrSsX3BOWi9x3DGZC1MW9FfGPw7t435p0RFZWG6yzYHb3U8SPP
         1qK2LnCaBeQ+TQ+Y4picX7Y0U9k6dtg1vfOJWxn0F3Vm5sMuVKsXnAlKaCI5UeaKdKar
         sUuA==
X-Received: by 10.107.128.30 with SMTP id b30mr3705062iod.84.1432219140814;
 Thu, 21 May 2015 07:39:00 -0700 (PDT)
Received: by 10.107.181.136 with HTTP; Thu, 21 May 2015 07:38:30 -0700 (PDT)
In-Reply-To: <CACsJy8AMhEKe-eM7jvYcEx+7ZmfvdD+p1s4VYHjKuAwZsDWc-w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269598>

On Thu, May 21, 2015 at 9:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> In case an object is not found pack directory
> is re-read again, which might cause some increased load on nfs.
> has_sha1_file() not finding the object should not happen often..

That last statement is probably very wrong, but I have no time to test
this now. In index-pack, there is a has_sha1_file() for file collision
test. That call on a fresh clone would fail for _every_ object in the
(new) pack and the cost of reprepare pack files could be sky high...
-- 
Duy
