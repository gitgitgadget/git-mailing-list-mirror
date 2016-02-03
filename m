From: "Klinger, Xia" <Xia.Klinger@cognex.com>
Subject: git 2.7.0 crashes when top-down memory allocation preference is set
Date: Wed, 3 Feb 2016 19:08:18 +0000
Message-ID: <9e3cc44087134954a3414fa8998c3ce6@USNAEXCP2.pc.cognex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:08:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aR2n0-0004nS-0i
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 20:08:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966121AbcBCTIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2016 14:08:25 -0500
Received: from mx2.cognex.com ([198.232.29.14]:28062 "EHLO mx2.cognex.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966066AbcBCTIY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2016 14:08:24 -0500
Received: from galileo.cognex.com ([10.10.128.32])
  by mx2.cognex.com with ESMTP; 03 Feb 2016 14:08:17 -0500
Received: from USNAEXCP1.pc.cognex.com (alt1adc1pip [10.10.128.111])
	by galileo.cognex.com (8.14.3/8.14.3) with ESMTP id u13J8IQP016365
	for <git@vger.kernel.org>; Wed, 3 Feb 2016 14:08:18 -0500 (EST)
Received: from USNAEXCP2.pc.cognex.com (10.3.160.222) by
 USNAEXCP1.pc.cognex.com (10.3.160.221) with Microsoft SMTP Server (TLS) id
 15.0.1044.25; Wed, 3 Feb 2016 14:08:18 -0500
Received: from USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a]) by
 USNAEXCP2.pc.cognex.com ([fe80::2d91:f69e:a2bf:334a%18]) with mapi id
 15.00.1044.021; Wed, 3 Feb 2016 14:08:18 -0500
Thread-Topic: git 2.7.0 crashes when top-down memory allocation preference is
 set
Thread-Index: AdFemzxLzKR7onqfTxCtkbzxea41AwAGsZHQ
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.3.128.111]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285373>

When the memory allocation preference is set to be Top-down on Windows and there are more than 4GB memory available, git will crash. The symptom is "Segmentation Fault".

How to reproduce
1. Install latest Git package on Windows 7 x64
2. Enable top-down memory allocation preference
3. Open Git bash
4. Type git -version
5. You will see the error message
6. Disable the top-down memory allocation preference
7. Run the same experience
8. You will see all works as expected.

How to enable top-down memory allocation preference
Add key HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Memory Management\AllocationPreference
Value : DWORD 0x00100000
