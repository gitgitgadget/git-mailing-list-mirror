From: Morten Welinder <mwelinder@gmail.com>
Subject: type_size_sort
Date: Tue, 6 Dec 2005 16:19:21 -0500
Message-ID: <118833cc0512061319l3726fdfbs8286e7b3f5ab0713@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Tue Dec 06 22:20:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjkDf-0004uZ-GQ
	for gcvg-git@gmane.org; Tue, 06 Dec 2005 22:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbVLFVTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Dec 2005 16:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVLFVTY
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Dec 2005 16:19:24 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:52849 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030246AbVLFVTW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 6 Dec 2005 16:19:22 -0500
Received: by zproxy.gmail.com with SMTP id v1so184197nzb
        for <git@vger.kernel.org>; Tue, 06 Dec 2005 13:19:22 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Yk1Wrve/QL+1P2VL3Kp2hmORqWi7e2ePHOoSnPsk97XczzAzAxS/NmcbPhDm82ajW5Mzgv6Zu7OqWnbzuwBaokZKRPekX4o02W3RJP6AOZoRDpeFGb5M8+LqSDfdWbd7cdExp18MNGi0eXATy0EWh62DD5sxmyIxw20rYLQXpLA=
Received: by 10.65.251.13 with SMTP id d13mr1034915qbs;
        Tue, 06 Dec 2005 13:19:21 -0800 (PST)
Received: by 10.65.151.1 with HTTP; Tue, 6 Dec 2005 13:19:21 -0800 (PST)
To: GIT Mailing List <git@vger.kernel.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13290>

static int type_size_sort(const struct object_entry *a, const struct
object_entry *b)
{
...
  return a < b ? -1 : (a > b);
}

This does not look valid.  the standard says you must not depend on the
location:


       [#4] When  the  same  objects  (consisting  of  size  bytes,
       irrespective  of  their  current positions in the array) are
       passed more  than  once  to  the  comparison  function,  the
       results  shall be consistent with one another.  That is, for
       qsort they shall define a total ordering on the  array,  and
       for  bsearch  the  same object shall always compare the same
       way with the key.


M.
