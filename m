From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 01/11] builtin/pack-objects.c: change check_pbase_path()
 to use ALLOC_GROW()
Date: Fri, 28 Feb 2014 15:20:09 +0100
Message-ID: <53109B19.8070103@alum.mit.edu>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru> <53105995.3010001@yandex.ru> <CACsJy8C2h13JFqh=CKvR=3TByHkxWCNR-XhK-WxA+DOE3GmvAQ@mail.gmail.com> <CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 15:20:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJOIY-0000lH-2a
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 15:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbaB1OUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 09:20:15 -0500
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:61623 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751959AbaB1OUN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 09:20:13 -0500
X-AuditID: 12074411-f79ab6d000002f0e-36-53109b1cd6cc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 95.CC.12046.C1B90135; Fri, 28 Feb 2014 09:20:12 -0500 (EST)
Received: from [192.168.69.148] (p57A2462E.dip0.t-ipconnect.de [87.162.70.46])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s1SEKA7o000491
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 28 Feb 2014 09:20:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20131103 Icedove/17.0.10
In-Reply-To: <CACsJy8AmQeVb-i6Sn0BH-_ikEXPHTdtKnQRyzChX1WfD9Lj4Jw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqCszWyDYYOo0XYuDW0+zW3Rd6Way
	6J7yltGB2WPnrLvsHp83yXkcbuhnCWCO4rZJSiwpC85Mz9O3S+DOWLn/P2vBKc6K5avWsjYw
	rmbvYuTkkBAwkbi1fCUrhC0mceHeerYuRi4OIYHLjBL/rn+Ecs4xSUyfuRasg1dAW+L4/bvM
	IDaLgKrE7kNfwOJsAroSi3qamUBsUYFgidWXH7BA1AtKnJz5BMwWEVCSeNOxDaiXg4NZIEOi
	eXEISFhYIFXi2co7ULveMEqc69sDVs8pECix9N0kNpB6CQFxiZ7GIIhWdYn184RAKpgF5CW2
	v53DPIFRcBaSZbMQqmYhqVrAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1SNdULzezRC81pXQT
	IySgBXcwzjgpd4hRgINRiYd3gid/sBBrYllxZe4hRkkOJiVR3lfTBYKF+JLyUyozEosz4otK
	c1KLDzFKcDArifA+aQLK8aYkVlalFuXDpKQ5WJTEefmWqPsJCaQnlqRmp6YWpBbBZGU4OJQk
	eJ/NBGoULEpNT61Iy8wpQUgzcXCCDOeSEilOzUtJLUosLcmIB0VvfDEwfkFSPEB7H4K08xYX
	JOYCRSFaTzHqctxu+/WJUYglLz8vVUqcNxWkSACkKKM0D24FLH29YhQH+liYl2kWUBUPMPXB
	TXoFtIQJaAmnJ9iSkkSElFQD40TDCydPZf+Sz4pnrWwNZDE6OUXolXZp0t4pc+yL7558c21P
	+6yd6wuMUv6++vf+1G+Z2zpNFVoJtXpTpnh9CIuq3uF8cM8/PsYjKuw6fxt6lgrZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242963>

On 02/28/2014 01:40 PM, Duy Nguyen wrote:
> On Fri, Feb 28, 2014 at 7:32 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>>>         done_pbase_paths_num++;
>>
>> If you move this up one line, then you don't have to "+ 1" in ALLOC_GROW
>>
> 
> same comment to a few other patches. The rest of your series looks good.

Duy,

The example in Documentation/technical/api-allocation-growing.txt does
it the same way as Dmitry:

    ALLOC_GROW(item, nr + 1, alloc);
    item[nr++] = value you like;

The alternative,

    nr++;
    ALLOC_GROW(item, nr, alloc);
    item[nr] = value you like;

is an extra line, which is at least a small argument for the variant
shown in the docs.  (Since ALLOC_GROW is a macro, it is not OK to use
"++nr" as its second argument.)  Personally, I also prefer the shorter
version.  The line

    item[nr++] = value

is an easy-to-recognize idiom, and

    ALLOC_GROW(item, nr + 1, alloc);

somehow makes it more transparent by how much more space will be needed.

So my vote is that the patches are OK the way Dmitry wrote them (mind, I
have only read through 05/11 so far).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
