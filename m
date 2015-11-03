From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 00/26] refs backend pre-vtable
Date: Tue, 03 Nov 2015 08:36:38 +0100
Message-ID: <56386406.302@alum.mit.edu>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 03 08:36:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtW9G-00042K-8V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:36:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbbKCHgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:36:50 -0500
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:62289 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751054AbbKCHgt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:36:49 -0500
X-AuditID: 1207440c-f79e16d000002a6e-1f-56386408545d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id EA.18.10862.80468365; Tue,  3 Nov 2015 02:36:40 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37ac5v016231
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:36:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsUixO6iqMuRYhFmcOiPhMX8TScYLbqudDM5
	MHkseH6f3ePzJrkApihum6TEkrLgzPQ8fbsE7ozzV/4xFnRzV1z+NZ+xgbGBs4uRk0NCwESi
	ffkDVghbTOLCvfVsXYxcHEIClxklrjevZ4VwzjJJ7FvTwAJSxSugLnFiyURmEJtFQFXi1YmX
	TCA2m4CuxKKeZjBbVCBIYsXyF4wQ9YISJ2c+AesVEXCQuLzrKFivsICpxKqH58DqhQQ8JBqv
	zAS7glPAU+LesXVgvcwCehI7rv9ihbDlJZq3zmaewMg/C8nYWUjKZiEpW8DIvIpRLjGnNFc3
	NzEzpzg1Wbc4OTEvL7VI11AvN7NELzWldBMjJCR5djB+WydziFGAg1GJh/fHMvMwIdbEsuLK
	3EOMkhxMSqK862IswoT4kvJTKjMSizPii0pzUosPMUpwMCuJ8BYEAuV4UxIrq1KL8mFS0hws
	SuK8qkvU/YQE0hNLUrNTUwtSi2CyMhwcShK88clAjYJFqempFWmZOSUIaSYOTpDhXFIixal5
	KalFiaUlGfGgmIwvBkYlSIoHaG9tEsje4oLEXKAoROspRkUpcd4IkLkCIImM0jy4sbBE84pR
	HOhLYd57IO08wCQF1/0KaDAT0ODwbaYgg0sSEVJSDYxLmQyuJLsqi7XNnnZDyyUy4a9PcXaR
	3rRlz+XmF4RzSz/6krHu/5OFjHzKWqe3FIqyyJbMkD1/TvHPnFsRM2INZJ1Nq9sNhZccilLf
	wSi64XhG1dQXb1OSXPucvkirP2V6/+XUJfPv6d82CPY131+zgoNzu/H2B/3nk+Z9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280753>

On 10/28/2015 03:14 AM, David Turner wrote:
> This version of the series makes some minor changes from v4:
> 
> refs.c: move refname_is_safe to the common code: clarify a comment
> initdb: move safe_create_dir into common code: add a caveat on safe_create_dir
> refs.c: move update_ref to refs.c: update commit message to include write_pseudoref
> refs.c: move delete_pseudoref and delete_ref to the common code: remove spurious
> added newline
> refs: make files_log_ref_write functions public: reword commit message
> refs.c: move ref iterators to the common code: added my DCO because this patch changed a bunch since Ronnie wrote it

Thanks for your re-roll. I think this series is almost ready. I already
sent a couple of minor comments about it, plus one bigger one: wouldn't
it be better to have a header file for declarations intended to be used
internally by the various refs backends but not be exposed to non-refs
code? I also think we agreed that the refs code could be moved to a
refs/ subdirectory.

So I revised your patch series, including a suggested new file naming
scheme and addressing my other comments. I will submit that version
shortly as v6.

Otherwise it all looks good. I've checked everything rather carefully
and didn't find any problems.

Thanks for your patience!

Michael

[1] https://github.com/mhagger/git

-- 
Michael Haggerty
mhagger@alum.mit.edu
