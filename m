From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] blame: simplify prepare_lines()
Date: Fri, 13 Jun 2014 14:46:42 -0700
Message-ID: <20140613214642.GM8557@google.com>
References: <539B569F.1090800@web.de>
 <539B5713.10300@web.de>
 <20140613211339.GL8557@google.com>
 <539B6E31.1080901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Fri Jun 13 23:46:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvZJE-0000tN-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 23:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155AbaFMVqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 17:46:48 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:63273 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754153AbaFMVqp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 17:46:45 -0400
Received: by mail-pd0-f178.google.com with SMTP id r10so2510802pdi.37
        for <git@vger.kernel.org>; Fri, 13 Jun 2014 14:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=26sPgCog9pZXZPbMZVF54HOVgC/ciWzH5QCAwC4oDfc=;
        b=r3lQA9bY4ft7ZCKk4Om+rIhCpufxkwupyPKdpwHa+1gEk+ciVttmNG/5BT9YGhQkqV
         brch3PC1+hEyntCq027Csxsv/ifv9bzuIJnDWlnIsuNKKSA0bYuw1eQErsH3OISDqbaG
         3Y8kuPyxrXNKHjXgGW+I75a+FdheWHPQDekg1EX7aNlSmlGrC5I4FJ3OAHuiOO9AORlF
         38ObsXRW9+lmqIPVOJ5RgxmyA8Ti/ppRW8H1nXG7x2FBLdtAMUGw/H0OjDmgUJRM8thb
         6tt+yJJtDfJyiN8ATdweFtn6q1P8XPIj90wU3jWzEfzddmCy6qwhqumyq7Gb5X0QHvD/
         HGkg==
X-Received: by 10.68.97.37 with SMTP id dx5mr6229922pbb.119.1402696005159;
        Fri, 13 Jun 2014 14:46:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ci4sm5341048pbb.50.2014.06.13.14.46.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 13 Jun 2014 14:46:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <539B6E31.1080901@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251642>

Hi,

Ren=E9 Scharfe wrote:

> There is no need to look at the caller -- the contents of the lineno
> array is not (intended to be) changed by the patch.

Ah.  If there is no incomplete line, the 'p < end' condition trips and
it doesn't try to record the nonexistent incomplete line.  Thanks for
explaining and sorry for the confusion.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
