From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Tue, 07 May 2013 05:14:40 +0200
Message-ID: <518871A0.8030707@alum.mit.edu>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com> <1367555502-4706-5-git-send-email-felipe.contreras@gmail.com> <87y5bw3q1s.fsf@hexa.v.cablecom.net> <CAMP44s1R9hAMZ=DQoPiTVi3+40NpADjVFU7tYovZA8W-PWEhhg@mail.gmail.com> <518785B3.3050606@alum.mit.edu> <87ip2wflg0.fsf@linux-k42r.v.cablecom.net> <518789D1.4010905@alum.mit.edu> <7v38u0t9va.fsf@alter.siamese.dyndns.org> <CAMP44s1HASAuF0ECCvJr66WeqopDzLZQ12pKFsc-j5_VCDrizg@mail.gmail.com> <CAMP44s2KHH1n0vHB0Mdv-M2xV97KA9FMc6UrPyYyxD+2jsvfTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 05:14:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZYMb-0006PY-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 05:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932246Ab3EGDOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 23:14:45 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:62610 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757313Ab3EGDOo (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 May 2013 23:14:44 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-10-518871a3f41e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id A4.AE.02295.3A178815; Mon,  6 May 2013 23:14:43 -0400 (EDT)
Received: from [192.168.69.140] (p57A24E33.dip0.t-ipconnect.de [87.162.78.51])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r473EepI014717
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 6 May 2013 23:14:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <CAMP44s2KHH1n0vHB0Mdv-M2xV97KA9FMc6UrPyYyxD+2jsvfTA@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsUixO6iqLu4sCPQ4OdDDYtfZ3exWBx8nGfR
	daWbyaKh9wqzRf/yLjaLu5dXsTuweeycdZfd48PHOI/br+cze1y8pOzxeZNcAGsUt01SYklZ
	cGZ6nr5dAnfGjkc9jAVHeSsmrW5jbGCczt3FyMkhIWAi0Xf5HyuELSZx4d56ti5GLg4hgcuM
	Em1znzFDOGeZJHa9XMsIUsUroC2xYd4hNhCbRUBV4v6/aWA2m4CuxKKeZiYQW1QgTGLV+mXM
	EPWCEidnPmEBsUUEDCX2tk9lARnKLHCMUWJP5wV2kISwgL3Eri/TWSG2TWCRePn3JFiCUyBQ
	4vnp1UAdHEAd6hLr5wmBhJkF5CW2v53DPIFRYBaSHbMQqmYhqVrAyLyKUS4xpzRXNzcxM6c4
	NVm3ODkxLy+1SNdQLzezRC81pXQTIyTUeXYwflsnc4hRgINRiYdX4VR7oBBrYllxZe4hRkkO
	JiVRXu70jkAhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrzS2kA53pTEyqrUonyYlDQHi5I4r+oS
	dT8hgfTEktTs1NSC1CKYrAwHh5IE794CoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTS
	kox4UKzGFwOjFSTFA7R3P0g7b3FBYi5QFKL1FKMux8orT14zCrHk5eelSonzTgMpEgApyijN
	g1sBS2yvGMWBPhbmXQxSxQNMinCTXgEtYQJaksDXDrKkJBEhJdXAyLL89pq6zgyXsLduAiuv
	KZbOkVbO+FbybqP9huuzL/msUYhR/L/rp0yQwJaXQYm2j/Y7rNxYcXThZrN3Ui8S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223534>

On 05/06/2013 11:36 PM, Felipe Contreras wrote:
> This would simplify the documentation, and obliterate the need to use
> mark files at all:

As explained in my other email, this documentation change does not
remove all of the reasons that users might want to use mark files.  I
would still like to show users how they can load the files into Git as
two separate steps.

> diff -ur cvs2svn-2.4.0/www/cvs2git.html cvs2svn-2.4.0-mod/www/cvs2git.html
> --- cvs2svn-2.4.0/www/cvs2git.html	2012-09-22 01:49:55.000000000 -0500
> +++ cvs2svn-2.4.0-mod/www/cvs2git.html	2013-05-06 16:33:12.070189985 -0500
> @@ -355,14 +355,13 @@
>        fast-import</tt>:</p>
> 
>  <pre>
> -git fast-import --export-marks=../cvs2svn-tmp/git-marks.dat &lt;
> ../cvs2svn-tmp/git-blob.dat
> -git fast-import --import-marks=../cvs2svn-tmp/git-marks.dat &lt;
> ../cvs2svn-tmp/git-dump.dat
> +cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import
>  </pre>
> 
> -    <p>On Linux/Unix this can be shortened to:</p>
> +    <p>On Windows you should use type instead:</p>
> 
>  <pre>
> -cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import
> +type ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git fast-import
>  </pre>
> 
>    </li>
> Only in cvs2svn-2.4.0-mod/www: .cvs2git.html.swp
> 
> 

Nevertheless, it *would* be nice to add the Windows equivalent of the
"cat" pipeline.  I knew about the "type" command but I was under the
impression that it is intended for text files and can corrupt binary
files.  Are you sure that using "type" as you suggest is binary-clean?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
