From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs.c: interpret @ as HEAD
Date: Tue, 30 Apr 2013 18:08:59 +0200
Message-ID: <517FEC9B.7020000@alum.mit.edu>
References: <1367324685-22788-1-git-send-email-artagnon@gmail.com> <87zjwguq8t.fsf@linux-k42r.v.cablecom.net> <20130430150430.GA13398@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 18:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXD77-0004nW-IQ
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 18:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760930Ab3D3QJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Apr 2013 12:09:05 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:48471 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760331Ab3D3QJD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Apr 2013 12:09:03 -0400
X-AuditID: 1207440d-b7fd06d000000905-d9-517fec9e8513
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id DA.CF.02309.E9CEF715; Tue, 30 Apr 2013 12:09:02 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3UG8xAJ019298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 30 Apr 2013 12:09:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130430150430.GA13398@lanh>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqDvvTX2gwaIX0harZj5mtzj4OM+i
	60o3k0VD7xVmi+4pbxkt7l5exe7A5rFz1l12j9uv5zN7XLyk7PF5k1wASxS3TVJiSVlwZnqe
	vl0Cd8azB3dZCr6xVnT2r2RuYLzM0sXIwSEhYCLReKKki5ETyBSTuHBvPVsXIxeHkMBlRol5
	jX9YIZzjTBLtPVOZQap4BbQl+o79ZwOxWQRUJXZ+f80EYrMJ6Eos6mkGs0UFwiRWrV8GVS8o
	cXLmExYQW0RASeJNxzZmkKHMAncYJfpnt4I1CAsYSLzeeIcJYls3o8Tjz0fAEpwCWhJfntxl
	BLGZBXQk3vU9YIaw5SW2v53DPIFRYBaSJbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJi
	Xl5qka6RXm5miV5qSukmRkiQ8+5g/L9O5hCjAAejEg+vwOX6QCHWxLLiytxDjJIcTEqivNwv
	gEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeH0eAuV4UxIrq1KL8mFS0hwsSuK8akvU/YQE0hNL
	UrNTUwtSi2CyMhwcShK8y14DNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDojW+
	GBivICkeoL0HQNp5iwsSc4GiEK2nGHU5Vl558ppRiCUvPy9VSpx3OUiRAEhRRmke3ApYSnvF
	KA70sTDvSZAqHmA6hJv0CmgJE9CSnVVgS0oSEVJSDYzaK/YzXAuyOKHIx3HRUyI0dh73xcNl
	ht6T3ptHsT0Mt7BWXqPgHOFecHHCS5eYnxzX795VCsn7WHJ4cfcD39lHereuLd5W 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222941>

On 04/30/2013 05:04 PM, Duy Nguyen wrote:
> On Tue, Apr 30, 2013 at 03:01:22PM +0200, Thomas Rast wrote:
>> What annoys me more is that there's no way to say
>>
>>   git symbolic-ref U @{u}
>>
>> so that I can avoid that -- it's really clumsy to type on a Swiss German
>> keyboard.  We'd need some sort of ref-alias feature for that to work.
> 
> It's not hard to do. The below patch makes "." equivalent to HEAD and
> ".U" -> "@{u}". Refs are not supposed to have '.' at the beginning, so
> it's easy to figure somebody is using alias from what they send
> you. Supporting refalias.* config should be easy.

So what does "git log master...U" mean?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
