From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 02/44] refs: make repack_without_refs and is_branch
 public
Date: Tue, 13 Oct 2015 04:39:36 +0200
Message-ID: <561C6EE8.3000301@alum.mit.edu>
References: <1444686725-27660-1-git-send-email-dturner@twopensource.com> <1444686725-27660-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 13 04:46:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlpc6-0006eo-1E
	for gcvg-git-2@plane.gmane.org; Tue, 13 Oct 2015 04:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbbJMCqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 22:46:50 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:53971 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932092AbbJMCqt (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2015 22:46:49 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Mon, 12 Oct 2015 22:46:49 EDT
X-AuditID: 1207440c-f79e16d000002a6e-65-561c6eea0f90
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 42.5D.10862.AEE6C165; Mon, 12 Oct 2015 22:39:38 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB2603.dip0.t-ipconnect.de [93.219.38.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t9D2dafd004253
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 12 Oct 2015 22:39:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.8.0
In-Reply-To: <1444686725-27660-3-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsUixO6iqPsqTybM4MkqVov5m04wWnRd6Way
	+DehxoHZY8GmUo8Fz++ze3zeJBfAHMVtk5RYUhacmZ6nb5fAnbGlbwdTQTNLxZclTewNjIuY
	uxg5OSQETCQ29H5lg7DFJC7cWw9kc3EICVxmlPg5fTsThHOWSeL63nWMIFW8AtoSc2+uYAex
	WQRUJc5ce8sKYrMJ6Eos6mlmArFFBYIkVix/AVUvKHFy5hMWEFtEwEHi8q6jYJuZBTQlNm14
	AdYrLBAssXLaLKhlrYwSl5+8AmvmFPCU2L/sEDtEg57Ejuu/WCFseYntb+cwT2AUmIVkxywk
	ZbOQlC1gZF7FKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZopeaUrqJERK8PDsYv62TOcQo
	wMGoxMP7IlImTIg1say4MvcQoyQHk5Iob10mUIgvKT+lMiOxOCO+qDQntfgQowQHs5II77ks
	oBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFqEUxWhoNDSYJ3Zi5Qo2BRanpqRVpm
	TglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoWuOLgfEKkuIB2vs9B2RvcUFiLlAUovUUoy7Hgh+3
	1zIJseTl56VKifMyg+wQACnKKM2DWwFLVa8YxYE+FuY1AaniAaY5uEmvgJYwAS0xYpcCWVKS
	iJCSamBkec+4se+ayPnUKaHRySt77x9zdbzM//OeFlusBHuh6LyVG5ttHrhllNgqGGv8//DU
	uvTQ4uLaGGbOmnOH/spwmPDfPqdzanvK87Iv1auNc9ZMCy60PHPN4q5sw03Wro2f 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279476>

On 10/12/2015 11:51 PM, David Turner wrote:
> is_branch was already non-static, but this patch declares it in the
> header.
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> [...]

It seems odd that repack_without_refs() should be made public (and
ultimately end up in refs.h) given that it intrinsically only has to do
with file-based references. But I will read on...

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
