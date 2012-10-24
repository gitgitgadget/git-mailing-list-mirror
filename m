From: Uri Moszkowicz <uri@4refs.com>
Subject: Re: Long clone time after "done."
Date: Wed, 24 Oct 2012 12:14:17 -0500
Message-ID: <CAMJd5ASAshzH3VTMkiOZZd5ODMoJa73=awpC7q4H7K+DVbBjKw@mail.gmail.com>
References: <CAMJd5AQBbnFqT5xrFuPOEsJevwDE=jUgBVFZ5KqTZk5zv5+NOw@mail.gmail.com>
 <CACsJy8DvNSVSUT_9ym52pVaDSNMk10WfaVGhfgQeC8+SOWSpEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 19:14:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TR4Xb-0000em-SJ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Oct 2012 19:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248Ab2JXROj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2012 13:14:39 -0400
Received: from mx71.nozonenet.com ([204.14.89.24]:54526 "EHLO
	mail3.nozonenet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758643Ab2JXROj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2012 13:14:39 -0400
Received: (qmail 17563 invoked by uid 399); 24 Oct 2012 13:14:38 -0400
Received: from mail-ie0-f174.google.com (smtp@4refs.com@209.85.223.174)
  (de-)crypted with TLSv1: RC4-SHA [128/128] DN=unknown
  by mail3.nozonenet.com with ESMTPSAM; 24 Oct 2012 13:14:38 -0400
X-Originating-IP: 209.85.223.174
X-Sender: smtp@4refs.com
Received: by mail-ie0-f174.google.com with SMTP id k13so1003746iea.19
        for <git@vger.kernel.org>; Wed, 24 Oct 2012 10:14:37 -0700 (PDT)
Received: by 10.50.15.132 with SMTP id x4mr3139930igc.58.1351098877498; Wed,
 24 Oct 2012 10:14:37 -0700 (PDT)
Received: by 10.64.15.7 with HTTP; Wed, 24 Oct 2012 10:14:17 -0700 (PDT)
In-Reply-To: <CACsJy8DvNSVSUT_9ym52pVaDSNMk10WfaVGhfgQeC8+SOWSpEw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208311>

It all goes to pack_refs() in write_remote_refs called from
update_remote_refs().

On Tue, Oct 23, 2012 at 11:29 PM, Nguyen Thai Ngoc Duy
<pclouds@gmail.com> wrote:
> On Wed, Oct 24, 2012 at 1:30 AM, Uri Moszkowicz <uri@4refs.com> wrote:
>> I have a large repository which I ran "git gc --aggressive" on that
>> I'm trying to clone on a local file system. I would expect it to
>> complete very quickly with hard links but it's taking about 6min to
>> complete with no checkout (git clone -n). I see the message "Clining
>> into 'repos'... done." appear after a few seconds but then Git just
>> hangs there for another 6min. Any idea what it's doing at this point
>> and how I can speed it up?
>
> "done." is printed by clone_local(), which is called in cmd_clone().
> After that there are just a few more calls. Maybe you could add a few
> printf in between these calls, see which one takes most time?
> --
> Duy
