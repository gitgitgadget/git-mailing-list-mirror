From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Git-aware HTTP transport
Date: Thu, 28 Aug 2008 22:11:25 -0700
Message-ID: <48B784FD.3080005@zytor.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com> <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com> <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com> <20080828035018.GA10010@spearce.org> <7vhc95iwcs.fsf@gitster.siamese.dyndns.org> <20080828145706.GB21072@spearce.org> <7vwsi0a2op.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 07:13:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYwIF-0002rQ-8N
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 07:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbYH2FMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 01:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbYH2FMB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 01:12:01 -0400
Received: from terminus.zytor.com ([198.137.202.10]:34514 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750856AbYH2FMA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 01:12:00 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.2/8.14.1) with ESMTP id m7T5BVA7029483
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 28 Aug 2008 22:11:32 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id m7T5BVCs030139;
	Thu, 28 Aug 2008 22:11:31 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.2/8.13.6) with ESMTP id m7T5BPfp008004;
	Thu, 28 Aug 2008 22:11:26 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <7vwsi0a2op.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.93.3/8115/Thu Aug 28 18:49:47 2008 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> 
>>> Is there a way to detect bad clients that does not obey this rule without
>>> server side states?
>> No.  Is that really a concern though?
> 
> I was more concerned about a bad/broken client not giving up forever, and
> not giving the server enough cue to give up, saying "I've conversed with
> this guy long enough but haven't reached the conclusion yet --- there is
> something wrong".  Even without server side states, if we were to trust
> clients, we can add "this is Nth round" to the protocol to help the server
> detect "long enough" part, but that somehow does not feel right.
> 

We should be able to detect either inconsistency, or lack of forward 
progress, but as long as there is forward progress made there doesn't 
seem to be a strong need to terminate.

	-hpa
